import 'flutter_pdf_generator_platform_interface.dart';

class FlutterPdfGenerator {
  Future<String?> convertHtmlToPdf(String htmlContent) {
    return FlutterPdfGeneratorPlatform.instance.convertHtmlToPdf(htmlContent);
  }
}
