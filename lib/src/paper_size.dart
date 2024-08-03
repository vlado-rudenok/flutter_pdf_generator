import 'double_extensions.dart';

enum DefinedPaperSize {
  a3(width: 11.69, height: 16.54),
  a4(width: 8.27, height: 11.69),
  a5(width: 5.83, height: 8.27),
  b4(width: 9.84, height: 13.90),
  b5(width: 6.93, height: 9.84),
  executive(width: 7.25, height: 10.5),
  legal(width: 8.5, height: 14),
  letter(width: 8.5, height: 11),
  tabloid(width: 11, height: 17);

  const DefinedPaperSize({required this.width, required this.height});

  final double width;
  final double height;
}

class PaperSize {
  const PaperSize.inches({
    required this.width,
    required this.height,
    required this.isPortrait,
  });

  PaperSize.cm({
    required double width,
    required double height,
    required this.isPortrait,
  })  : width = width.cmToInches(),
        height = height.cmToInches();

  PaperSize.mm({
    required double width,
    required double height,
    required this.isPortrait,
  })  : width = width.mmToInches(),
        height = height.mmToInches();

  factory PaperSize.defined(
    DefinedPaperSize size, {
    required bool isPortrait,
  }) =>
      PaperSize.inches(
        width: size.width,
        height: size.height,
        isPortrait: isPortrait,
      );

  final double width;
  final double height;
  final bool isPortrait;

  Map<String, double> toMap() => {'width': orientedWidth, 'height': orientedHeight};

  double get orientedHeight => isPortrait ? height : width;
  double get orientedWidth => isPortrait ? width : height;
}
