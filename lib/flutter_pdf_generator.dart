import 'flutter_pdf_generator.dart';
import 'flutter_pdf_generator_platform_interface.dart';

export 'src/paper_size.dart';

class FlutterPdfGenerator {
  FlutterPdfGenerator._();

  static Future<String?> convertHtmlToPdf({
    required String htmlContent,
    required PaperSize size,
    required String savedPath,
    String? footerText,
    String? headerText,
  }) =>
      FlutterPdfGeneratorPlatform.instance.convertHtmlToPdf(htmlContent);
}
