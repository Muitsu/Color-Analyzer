import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'dominant_color.dart';
import 'dominant_color_stat.dart';

class DominantColorDetector {
  /// Main function to run in an isolate. Takes image bytes and returns dominant color stats.
  static Future<List<DominantColorStat>> analyze(
    Uint8List bytes, {
    int maxSize = 150,
  }) async {
    return _processImage(bytes, maxSize: maxSize);
  }

  /// Internal image processing logic. Decodes image and counts pixel color frequencies.
  static List<DominantColorStat> _processImage(
    Uint8List bytes, {
    int maxSize = 150,
  }) {
    final image = img.decodeImage(bytes);
    if (image == null) return [];
    // Resize to smaller size while maintaining aspect ratio
    final resized = img.copyResize(
      image,
      width: image.width > image.height ? maxSize : null,
      height: image.height >= image.width ? maxSize : null,
    );

    final colorCount = <DominantColor, int>{};

    for (int y = 0; y < resized.height; y += 3) {
      for (int x = 0; x < resized.width; x += 3) {
        final pixel = resized.getPixel(x, y);
        final r = pixel.r;
        final g = pixel.g;
        final b = pixel.b;

        final closest = _getClosestNamedColor(r, g, b);
        colorCount[closest] = (colorCount[closest] ?? 0) + 1;
      }
    }

    final total = colorCount.values.fold(0, (a, b) => a + b);
    if (total == 0) return [];

    final result = colorCount.entries.map((entry) {
      final percentage = entry.value / total;
      return DominantColorStat(
        color: entry.key,
        percentage: (percentage * 100),
      );
    }).toList();

    result.sort((a, b) => b.percentage.compareTo(a.percentage));

    return result.where((e) => e.percentage > 0.01).take(10).toList();
  }

  /// Finds the closest [DominantColor] enum based on RGB distance.
  static DominantColor _getClosestNamedColor(num r, num g, num b) {
    double minDistance = double.infinity;
    DominantColor? closest;

    for (final namedColor in DominantColor.values) {
      final c = namedColor.color;
      final dr = r - ((c.r * 255.0).round() & 0xff);
      final dg = g - ((c.g * 255.0).round() & 0xff);
      final db = b - ((c.b * 255.0).round() & 0xff);

      // Weighted Euclidean distance — accounts for human vision sensitivity
      final distance = 0.30 * dr * dr + 0.59 * dg * dg + 0.11 * db * db;

      if (distance < minDistance) {
        minDistance = distance;
        closest = namedColor;
      }
    }

    return closest!;
  }
}
