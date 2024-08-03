import 'package:flutter/services.dart';
import 'package:flutter_pdf_generator/flutter_pdf_generator_method_channel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final platform = MethodChannelFlutterPdfGenerator();
  const channel = MethodChannel('flutter_pdf_generator');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (methodCall) async => '42',
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('convertHtmlToPdf', () async {
    expect(await platform.convertHtmlToPdf(''), '');
  });
}
