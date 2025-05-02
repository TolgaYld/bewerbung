import 'dart:ui';

extension HexColorParsing on String {
  Color? toColor() {
    final hex = replaceFirst('#', '');
    final buffer = StringBuffer();
    if (hex.length == 6) buffer.write('ff');
    buffer.write(hex);
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension ColorToHex on Color {
  String toHex({bool leadingHashSign = true}) {
    final hexValue = toARGB32().toRadixString(16).padLeft(8, '0');
    return '${leadingHashSign ? '#' : ''}${hexValue.substring(2)}';
  }
}
