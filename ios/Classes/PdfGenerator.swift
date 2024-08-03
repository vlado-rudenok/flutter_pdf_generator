
import Flutter
import UIKit
import WebKit

class PdfGenerator {
    var webView: WKWebView!
    var urlObservation: NSKeyValueObservation?
    
    func generatePdf(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as? [String: Any]

        guard let arguments else  {
            result(nil)
            return
        }

        let content = arguments["content"] as? String
        let path = arguments["savedPath"] as? String

        guard let path else {
            result(nil)
            return
        }

        let savedPath = URL(fileURLWithPath: path).path
        let format = arguments["format"] as? [String: Double]
        let margins = arguments["margins"] as? Dictionary<String, Double>

        guard let content,
              let margins,
              let format else {
            result(nil)
            return
        }
        
        let duration = (arguments["duration"] as? Double) ?? 2000.0
        let footerText = arguments["footerText"] as? String
        let headerText = arguments["headerText"] as? String

        self.webView = WKWebView()
        self.webView.isHidden = true
        self.webView.loadHTMLString(content, baseURL: Bundle.main.resourceURL)

        urlObservation = webView.observe(\.isLoading, options: [.new]) { [weak self] (webView, change) in
            guard let self = self else { return }
            if !webView.isLoading {
                DispatchQueue.main.asyncAfter(deadline: .now() + (duration / 10000)) {
                    guard let path = self.webView.exportAsPdfFromWebView(
                        savedPath: savedPath,
                        format: format,
                        margins: margins,
                        footerText: footerText,
                        headerText: headerText) else {
                        result(nil)
                        return
                    }
                    result(path)
                    self.dispose()
                }
            }
        }
    }

    func dispose() {
        if let webView = self.webView {
            webView.removeFromSuperview()
            WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
                records.forEach { record in
                    WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                }
            }
            urlObservation?.invalidate()
            urlObservation = nil
        }
        self.webView = nil
    }
}
