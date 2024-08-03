import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_pdf_generator_platform_interface.dart';

/// An implementation of [FlutterPdfGeneratorPlatform] that uses method channels.
class MethodChannelFlutterPdfGenerator extends FlutterPdfGeneratorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_pdf_generator');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
