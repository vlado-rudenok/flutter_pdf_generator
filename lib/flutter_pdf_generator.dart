
import 'flutter_pdf_generator_platform_interface.dart';

class FlutterPdfGenerator {
  Future<String?> getPlatformVersion() {
    return FlutterPdfGeneratorPlatform.instance.getPlatformVersion();
  }
}
