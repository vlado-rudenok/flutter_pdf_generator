import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_pdf_generator_method_channel.dart';

abstract class FlutterPdfGeneratorPlatform extends PlatformInterface {
  /// Constructs a FlutterPdfGeneratorPlatform.
  FlutterPdfGeneratorPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPdfGeneratorPlatform _instance = MethodChannelFlutterPdfGenerator();

  /// The default instance of [FlutterPdfGeneratorPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPdfGenerator].
  static FlutterPdfGeneratorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPdfGeneratorPlatform] when
  /// they register themselves.
  static set instance(FlutterPdfGeneratorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> convertHtmlToPdf({
    required String htmlContent,
    required String savedPath,
    required Map<String, double> margins,
    required Map<String, double> size,
    String? footerText,
    String? headerText,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
