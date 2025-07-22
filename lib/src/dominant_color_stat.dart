import 'dominant_color.dart';

class DominantColorStat {
  final DominantColor color;
  final double percentage; // 0.0 to 1.0

  DominantColorStat({required this.color, required this.percentage});

  @override
  String toString() =>
      '${color.label}: ${(percentage * 100).toStringAsFixed(2)}%';
}
