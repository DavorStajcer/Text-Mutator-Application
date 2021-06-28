import 'package:flutter/material.dart';

class AnimatedPointer extends StatelessWidget {
  final Offset pointerOffset;
  final Duration pointerOffsetDuration;
  final double pointerRadius;
  const AnimatedPointer({
    Key? key,
    required this.pointerOffset,
    required this.pointerOffsetDuration,
    required this.pointerRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: pointerOffset.dy,
      curve: Curves.easeOutExpo,
      left: pointerOffset.dx,
      duration: pointerOffsetDuration,
      child: CustomPaint(
        foregroundPainter: PointerPainter(
          pointerRadius: pointerRadius,
        ),
      ),
    );
  }
}

class PointerPainter extends CustomPainter {
  final double pointerRadius;
  PointerPainter({
    required this.pointerRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final _paint = Paint()
      ..blendMode = BlendMode.difference
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(0, 0), pointerRadius, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
