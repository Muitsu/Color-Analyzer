import 'package:flutter/material.dart';
import 'package:dominant_color_detector/dominant_color_detector.dart'; // <- Your package import

class ColorSwatchList extends StatelessWidget {
  final void Function(int index)? onTap;
  final int groupValue;
  final List<DominantColorStat> colors;

  const ColorSwatchList(
    this.colors, {
    super.key,
    required this.groupValue,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: colors.asMap().entries.map((entry) {
        final index = entry.key;
        final c = entry.value;
        final color = c.color.color;
        return GestureDetector(
          onTap: () => onTap?.call(index),
          child: Container(
            margin: const EdgeInsets.all(4),
            padding: EdgeInsets.all(index == groupValue ? 2 : 0),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Container(
              width: 50,
              height: 50,

              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black26, width: 5),
              ),
              child: Center(
                child: Text(
                  '${c.percentage.toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: color.computeLuminance() > 0.5
                        ? Colors.black
                        : Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
