import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_pdf_generator_platform_interface.dart';

/// An implementation of [FlutterPdfGeneratorPlatform] that uses method channels.
class MethodChannelFlutterPdfGenerator extends FlutterPdfGeneratorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_pdf_generator');

  @override
  Future<String?> convertHtmlToPdf({
    required String htmlContent,
    required String savedPath,
    required Map<String, double> margins,
    required Map<String, double> size,
    String? footerText,
    String? headerText,
  }) async {
    final arguments = <String, dynamic>{
      'content': htmlContent,
      'duration': null,
      'savedPath': savedPath,
      'margins': margins,
      'format': size,
      if (footerText != null) 'footerText': footerText,
      if (headerText != null) 'headerText': headerText,
    };
    final version = await methodChannel.invokeMethod<String?>('convertHtmlToPdf', arguments);
    return version;
  }
}
