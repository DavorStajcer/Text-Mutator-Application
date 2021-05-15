import 'package:vector_math/vector_math.dart' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DifficultyRepresentationWidget extends StatelessWidget {
  final int difficulty;
  final TextStyle textStyle;
  final Color circleRepresentationColor;
  const DifficultyRepresentationWidget({
    Key? key,
    required this.difficulty,
    required this.textStyle,
    required this.circleRepresentationColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              'DIFFICULTY',
              style: textStyle,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: AutoSizeText(
                    difficulty.toString(),
                    style: textStyle.copyWith(fontSize: 40),
                  ),
                ),
                Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CustomPaint(
                      foregroundPainter: DataCircleRepresentationPainter(
                        percentage: 0.6,
                        mainPaintColor: circleRepresentationColor,
                      ),
                      child: SizedBox.expand(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DataCircleRepresentationPainter extends CustomPainter {
  final double percentage;
  final Color mainPaintColor;

  DataCircleRepresentationPainter({
    required this.mainPaintColor,
    required this.percentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint _paint = Paint()
      ..color = mainPaintColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke;

    final Rect _rect = Rect.fromLTWH(
        size.width / 4, size.height / 4, size.width / 2, size.height / 2);

    canvas.drawArc(
      _rect,
      math.radians(0),
      math.radians(270),
      false,
      _paint,
    );
  }

  @override
  bool shouldRepaint(covariant DataCircleRepresentationPainter oldDelegate) {
    return oldDelegate.percentage != this.percentage;
  }
}
