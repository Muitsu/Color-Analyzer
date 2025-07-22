import 'package:example/color_swatch.dart';
import 'package:flutter/material.dart';
import 'package:dominant_color_detector/dominant_color_detector.dart'; // <- Your package import

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ColorDemoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ColorDemoPage extends StatefulWidget {
  const ColorDemoPage({super.key});

  @override
  State<ColorDemoPage> createState() => _ColorDemoPageState();
}

class _ColorDemoPageState extends State<ColorDemoPage> {
  List<DominantColorStat> stats = [];
  int groupValue = 0;

  final imageUrl =
      'https://upload.wikimedia.org/wikipedia/commons/a/a4/2019_Toyota_Corolla_Icon_Tech_VVT-i_Hybrid_1.8.jpg';

  @override
  void initState() {
    super.initState();
    _analyze();
  }

  Future<void> _analyze() async {
    final imageBytes = await fetchImageBytes(imageUrl);
    final result = await DominantColorDetector.analyze(imageBytes);
    setState(() => stats = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dominant Colors')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            const SizedBox(height: 16),
            Text(
              "Selected color: ${stats.isNotEmpty ? stats[groupValue].color.label : 'None'}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            ColorSwatchList(
              stats,
              groupValue: groupValue,
              onTap: (index) {
                setState(() => groupValue = index);
              },
            ),
          ],
        ),
      ),
    );
  }
}
