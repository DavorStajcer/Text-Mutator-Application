import 'package:vector_math/vector_math.dart' as math;
import 'dart:ui' as ui;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DifficultyRepresentationWidget extends StatelessWidget {
  final int difficulty;
  final TextStyle textStyle;
  final Color innerCircleRadialGradientColor;
  final Color outerCircleRadialGradiantColor;
  final Color circleRepresentationColor;
  const DifficultyRepresentationWidget({
    Key? key,
    required this.difficulty,
    required this.textStyle,
    required this.circleRepresentationColor,
    required this.innerCircleRadialGradientColor,
    required this.outerCircleRadialGradiantColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
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
                    aspectRatio: 2,
                    child: CustomPaint(
                      foregroundPainter: DataCircleRepresentationPainter(
                        innerCircleRadialGradientColor:
                            innerCircleRadialGradientColor,
                        outerCircleRadialGradiantColor:
                            outerCircleRadialGradiantColor,
                        percentage: (difficulty / 100) * 360,
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
  final Color innerCircleRadialGradientColor;
  final Color outerCircleRadialGradiantColor;

  DataCircleRepresentationPainter({
    required this.innerCircleRadialGradientColor,
    required this.outerCircleRadialGradiantColor,
    required this.mainPaintColor,
    required this.percentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint _paint = Paint()
      ..color = mainPaintColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20
      ..shader = ui.Gradient.radial(
        Offset(size.width / 2, size.height / 2),
        size.width / 3.6,
        [
          innerCircleRadialGradientColor,
          outerCircleRadialGradiantColor,
        ],
      )
      ..style = PaintingStyle.stroke;

    final Rect _rect =
        Rect.fromLTWH(size.width / 4, 0, size.width / 2, size.height);

    canvas.drawArc(
      _rect,
      math.radians(-90),
      math.radians(percentage),
      false,
      _paint,
    );
  }

  @override
  bool shouldRepaint(covariant DataCircleRepresentationPainter oldDelegate) {
    return oldDelegate.percentage != this.percentage;
  }
}
