import RxSwift
import Vision
import AVFoundation
import UIKit

class CameraViewController: ViewController, CameraModule {
    var errorTapped: Callback?
    
    var showSucces: ShowSuccess?
    
    var giveCredit: GiveCredit?
    
    var payCredit: PayCredit?
    
    var cameraActionType: CameraAction?
    
    private var avCaptureOuput: AVCaptureOutput?
    private let avCaptureSession: AVCaptureSession
    private var avCaptureDevice: AVCaptureDevice
    private let avCapturePreviewLayer: AVCaptureVideoPreviewLayer
    private var avCaptureMetadaDegelegate: CameraMetadaOutputDelegate?
    private let cameraUsagePermission: CameraUsagePermission
    private let disposeBag = DisposeBag()
    private let cameraView = CameraView()
    private let viewModel: CameraViewModel
    private var request: [VNRequest] = []

    init(
        avCaptureSession: AVCaptureSession,
        avCaptureDevice: AVCaptureDevice,
        avCapturePreviewLayer: AVCaptureVideoPreviewLayer,
        cameraUsagePermession: CameraUsagePermission,
        viewModel: CameraViewModel
    ) {
        self.avCaptureSession = avCaptureSession
        self.avCaptureDevice = avCaptureDevice
        self.avCapturePreviewLayer = avCapturePreviewLayer
        self.cameraUsagePermission = cameraUsagePermession
        self.viewModel = viewModel
        avCaptureMetadaDegelegate = CameraMetadaOutputDelegate()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        switch cameraActionType {
        case .payCredit:
            title = "Погашение микрокредита"
            cameraView.titleLabel.text = "Отсканируйте QR код клиента \nдля погашения микрокредита"
        default:
            title = "Выдача микрокредита"
        }
    }

    private func bindViewModel() {
        switch cameraUsagePermission.avAuthorizationStatus {
        case .authorized:
            DispatchQueue.main.async {
                self.setupCamera()
            }
        default:
            cameraUsagePermission.checkStatus()
            addEmptyButton()
        }
        
        cameraUsagePermission.isAccesGranted
            .subscribe(onNext: { [unowned self] isEnabled in
                if isEnabled {
                    DispatchQueue.main.async {
                        self.setupCamera()
                    }
                } else {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }).disposed(by: disposeBag)
        
        avCaptureMetadaDegelegate?.qrScanned = { [unowned self] qr in
            self.avCaptureSession.stopRunning()
            switch self.cameraActionType {
            case .giveCredit:
                qrScanned(qr: qr)
            case .payCredit:
                qrScanned(qr: qr)
            default:
                return
            }
        }
    }

    private func qrScanned(qr: qrResult) {
        switch cameraActionType {
        case .giveCredit:
            giveCredit?(qr)
        case .payCredit:
            presentCustomAlert(type: .getCreditPay(sum: "\(qr.CreditSum)", fio: qr.FIO), firstButtonAction: { [unowned self] in
                self.viewModel.clientId = qr.ClientID
                self.viewModel.creditId = qr.CreditID
                let clear = self.viewModel.transform(input: .init(clearTapped: .just(())))
                let output = clear.response.publish()
                
                output.element
                    .subscribe(onNext: { [unowned self] res in
                        if res.Success {
                            self.dismiss(animated: true) {
                                self.showSucces?(qr, res.Data)
                            }
                        } else {
                            self.dismiss(animated: true) {
                                showErrorAlert(title: "Ошибка", message: res.Message) {
                                    self.errorTapped?()
                                }
                        }
                        }
                    }).disposed(by: disposeBag)
                
                output.loading
                    .bind(to: ProgressView.instance.rx.loading)
                    .disposed(by: disposeBag)
                
                output.errors
                    .bind(to: rx.error)
                    .disposed(by: disposeBag)
                
                output.connect()
                    .disposed(by: disposeBag)
                
            }, secondButtonAction:  {
                self.dismiss(animated: true) {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        default:
            return
        }
    }

    private func setupCamera() {
        addCameraSession()
        addCameraOutput()
        addPreviewLayer()
    }

    private func addCameraSession() {
        guard let input = try? AVCaptureDeviceInput(device: avCaptureDevice) else { return }
        avCaptureSession.addInput(input)
    }

    private func addCameraOutput() {
        let output = AVCaptureMetadataOutput()
        avCaptureSession.addOutput(output)
        output.setMetadataObjectsDelegate(avCaptureMetadaDegelegate, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        avCaptureSession.startRunning()
    }

    private func addPreviewLayer() {
        avCapturePreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avCapturePreviewLayer.frame = view.bounds
        view.layer.addSublayer(avCapturePreviewLayer)
        cameraView.frame = view.frame
        view.addSubview(cameraView)
    }
    
    override func customBackButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    private func addEmptyButton() {
        let button = UIButton()
        view.addSubview(button)
        button.setTitle("Для сканирования QR, дайте доступ к камере", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.primary, for: .normal)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        button.rx.tap
            .subscribe(onNext: { [unowned self] in
                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                   return
                }
                if UIApplication.shared.canOpenURL(url) {
                   UIApplication.shared.open(url, options: [:])
                }
            })
            .disposed(by: disposeBag)
    }
}

