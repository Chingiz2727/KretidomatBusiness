import AVFoundation
protocol CameraMetadataOutput {
    typealias QrScanned = (qrResult) -> Void

    var qrScanned: QrScanned? { get set }
}

final class CameraMetadaOutputDelegate: NSObject, AVCaptureMetadataOutputObjectsDelegate, CameraMetadataOutput {
    var qrScanned: QrScanned?

    func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        guard let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject else { return }
        if object.type == .qr {
            guard let objectString = object.stringValue?.replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: "", with: "").replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "") else { return }
            let array = objectString.split(separator: .init(","))
            let values = array.map { $0.split(separator: ":").last}
            self.qrScanned?(qrResult(FIO: "kaira", CreditSum: 1000, ClientID: 5, CreditID: 12))
        }
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}

extension String {
    func getCharacerByInde() {
        
    }
}
