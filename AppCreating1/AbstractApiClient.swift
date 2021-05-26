import UIKit
import YMTGetDeviceName

class AbstractApiClient: NSObject {
    struct Response {
        let success: Bool
        let errorCode: Int
        let data: [String: Any?]
    }

    var path = "/"

    var url: URL {
        get {
            let host = "app-creating-1.arakaki.app/api"

            return URL(string: "https://\(host)\(path)")!
        }
    }

    let crlf = Data([0x0D, 0x0A])

    var dataTask: URLSessionDataTask? = nil

    var boundary = ""

    var payload = Data()

    var request: URLRequest? = nil

    func cancel() {
        dataTask?.cancel()

        request = nil
        boundary = ""
        payload = Data()
        dataTask = nil
    }

    func resumeDataTask(_ callback: @escaping (Response) -> Void) {
        if let deviceUuid = UIDevice.current.identifierForVendor?.uuidString {
            request?.setValue(deviceUuid, forHTTPHeaderField: "X-Device-Uuid")
        }

        request?.setValue(YMTGetDeviceName.share.getDeviceName(), forHTTPHeaderField: "X-Device-Name")

        request?.setValue(String(format: "%@ %@", arguments: [
            UIDevice.current.systemName,
            UIDevice.current.systemVersion,
        ]), forHTTPHeaderField: "X-Device-System")

        request?.setValue(TimeZone.current.identifier, forHTTPHeaderField: "X-Device-Timezone")

        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            request?.setValue(appVersion, forHTTPHeaderField: "X-App-Version")
        }

        if !payload.isEmpty {
            request?.httpBody = payload
        }

        guard let request = request else {
            callback(Response(success: false, errorCode: 0xFFFF, data: [:]))

            return
        }

        dataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let error = error {
                callback(Response(success: false, errorCode: 0xFF00, data: [
                    "error_message": error.localizedDescription,
                ]))

                return
            }

            guard let data = data else {
                callback(Response(success: false, errorCode: 0xFF01, data: [
                    "error_message": NSLocalizedString("Failed to read data from response.", comment: ""),
                ]))

                return
            }

            guard
                let responseJson = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let success = responseJson["success"] as? Bool,
                let errorCode = responseJson["error_code"] as? Int,
                let responseData = responseJson["data"] as? [String: Any?]
            else {
                callback(Response(success: false, errorCode: 0xFF02, data: [
                    "error_message": NSLocalizedString("Failed to read data from response.", comment: ""),
                ]))

                return
            }

            callback(Response(success: success, errorCode: errorCode, data: responseData))
        })

        dataTask?.resume()
    }
}
