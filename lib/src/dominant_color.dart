import 'package:flutter/material.dart';

/// Enhanced enum for named dominant colors with associated RGB and hex values.
enum DominantColor {
  red(Color(0xFFFF0000), 'Red'),
  green(Color(0xFF00FF00), 'Green'),
  blue(Color(0xFF0000FF), 'Blue'),
  yellow(Color(0xFFFFFF00), 'Yellow'),
  cyan(Color(0xFF00FFFF), 'Cyan'),
  magenta(Color(0xFFFF00FF), 'Magenta'),
  black(Color(0xFF000000), 'Black'),
  white(Color(0xFFFFFFFF), 'White'),
  gray(Color(0xFF808080), 'Gray'),
  orange(Color(0xFFFFA500), 'Orange'),
  pink(Color(0xFFFFC0CB), 'Pink'),
  purple(Color(0xFF800080), 'Purple'),
  brown(Color(0xFFA52A2A), 'Brown'),
  lime(Color(0xFFBFFF00), 'Lime'),
  navy(Color(0xFF000080), 'Navy'),
  teal(Color(0xFF008080), 'Teal'),
  olive(Color(0xFF808000), 'Olive'),
  maroon(Color(0xFF800000), 'Maroon'),
  gold(Color(0xFFFFD700), 'Gold'),
  indigo(Color(0xFF4B0082), 'Indigo');

  final Color color;
  final String label;

  const DominantColor(this.color, this.label);

  String get hex =>
      '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';

  /// Returns the RGB as a map for convenience
  Map<String, num> get rgb => {
    'r': ((color.r * 255.0).round() & 0xff),
    'g': ((color.g * 255.0).round() & 0xff),
    'b': ((color.b * 255.0).round() & 0xff),
  };

  @override
  String toString() => label;
}
