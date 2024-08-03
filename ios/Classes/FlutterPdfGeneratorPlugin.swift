import Flutter
import UIKit

public class FlutterPdfGeneratorPlugin: NSObject, FlutterPlugin {

  let generator = PdfGenerator()

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_pdf_generator", binaryMessenger: registrar.messenger())
    let instance = FlutterPdfGeneratorPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "convertHtmlToPdf":
      generator.generatePdf(call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
