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
            let result = qrResult(FIO: String(values[0] ?? ""), CreditSum: String(values[1] ?? ""), ClientID: String(values[2] ?? ""), CreditID: String(values[3] ?? ""), IIN: String(values[4] ?? ""))
            self.qrScanned?(result)
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
