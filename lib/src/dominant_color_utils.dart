import 'package:flutter/material.dart';
import 'dominant_color.dart';

class DominantColorUtils {
  /// Returns a swatch widget for preview
  static Widget swatch(DominantColor color, {double size = 40}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black12),
      ),
    );
  }

  /// Converts enum to hex string
  static String toHex(DominantColor color) => color.hex;

  /// Converts enum to Flutter `Color`
  static Color toColor(DominantColor color) => color.color;

  /// Returns label of the color
  static String label(DominantColor color) => color.label;
}
