import 'package:flutter/material.dart';

class BarGraph extends StatelessWidget {
  final List<int> data;
  final List<String> labels;

  const BarGraph({
    super.key,
    required this.data,
    this.labels = const ['Invitations', 'Wishes', 'Special interviews', 'Basic interviews'],
  });

  @override
  Widget build(BuildContext context) {
    final paddingFromAxes = 20.0;
    const graphHeight = 250.0;

    return Card(
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomPaint(
              size: Size(double.infinity, graphHeight),
              painter: BarGraphPainter(data: data, labels: labels, paddingFromAxes: paddingFromAxes),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: labels.map((label) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class BarGraphPainter extends CustomPainter {
  final List<int> data;
  final List<String> labels;
  final double paddingFromAxes;

  BarGraphPainter({
    required this.data,
    required this.labels,
    required this.paddingFromAxes,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.stroke..strokeWidth = 2.0;
    final barPaint = Paint()..color = const Color(0xFF344BFD);
    const maxVal = 100; // Max percentage value (100%)
    final graphHeight = size.height - 2 * paddingFromAxes;
    final scaleFactor = graphHeight / maxVal;
    final barWidth = (size.width - 2 * paddingFromAxes) / (data.length * 2);
    final originX = paddingFromAxes;
    final originY = size.height - paddingFromAxes;

    // Draw x-axis
    paint.color = Colors.black;
    canvas.drawLine(Offset(originX, originY), Offset(size.width - paddingFromAxes, originY), paint);

    // Draw y-axis
    canvas.drawLine(Offset(originX, originY), Offset(originX, paddingFromAxes), paint);

    // Draw bars
    for (var i = 0; i < data.length; i++) {
      final barLeft = originX + (barWidth * 2 * i) + barWidth / 2;
      final barTop = originY - (data[i] * scaleFactor);
      final barSize = Size(barWidth, data[i] * scaleFactor);
      canvas.drawRect(Rect.fromLTWH(barLeft, barTop, barSize.width, barSize.height), barPaint);
    }

    // Draw y-axis labels (0% to 100%)
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    const yAxisLabelCount = 5;
    final yAxisStep = maxVal / yAxisLabelCount;
    for (var i = 0; i <= yAxisLabelCount; i++) {
      final yValue = i * yAxisStep;
      final yPosition = originY - (yValue * scaleFactor);
      final yLabel = '$yValue%';
      textPainter.text = TextSpan(
        text: yLabel,
        style: const TextStyle(color: Colors.black, fontSize: 12.0),
      );
      textPainter.layout();
      final yLabelX = originX - paddingFromAxes - textPainter.width;
      final yLabelY = yPosition - textPainter.height / 2;
      textPainter.paint(canvas, Offset(yLabelX, yLabelY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class BarGraphScreen extends StatelessWidget {
  const BarGraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bar Graph',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          BarGraph(data: const [10, 30, 20, 60]), // Example data (percentages)
        ],
      ),
    );
  }
}