import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pdf_generator/flutter_pdf_generator.dart';
import 'package:flutter_pdf_generator/flutter_pdf_generator_platform_interface.dart';
import 'package:flutter_pdf_generator/flutter_pdf_generator_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPdfGeneratorPlatform
    with MockPlatformInterfaceMixin
    implements FlutterPdfGeneratorPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterPdfGeneratorPlatform initialPlatform = FlutterPdfGeneratorPlatform.instance;

  test('$MethodChannelFlutterPdfGenerator is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPdfGenerator>());
  });

  test('getPlatformVersion', () async {
    FlutterPdfGenerator flutterPdfGeneratorPlugin = FlutterPdfGenerator();
    MockFlutterPdfGeneratorPlatform fakePlatform = MockFlutterPdfGeneratorPlatform();
    FlutterPdfGeneratorPlatform.instance = fakePlatform;

    expect(await flutterPdfGeneratorPlugin.getPlatformVersion(), '42');
  });
}
