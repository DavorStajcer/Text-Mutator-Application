import 'package:flutter/material.dart';

class ProgressAnimatedCircle extends StatelessWidget {
  const ProgressAnimatedCircle({
    Key? key,
    required ThemeData theme,
    required double circleWidth,
    required final double beginAnimation,
    required final double endAnimation,
    required final AnimationController animationController,
  })   : _theme = theme,
        _circleWidth = circleWidth,
        _animationController = animationController,
        _endAnimation = endAnimation,
        _beginAnimation = beginAnimation,
        super(key: key);

  final ThemeData _theme;
  final double _circleWidth;
  final double _endAnimation;
  final double _beginAnimation;
  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: _theme.primaryColor,
          shape: BoxShape.circle,
          border:
              Border.all(color: _theme.textTheme.bodyText1!.color!, width: 1)),
      child: ScaleTransition(
        scale: Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Interval(
              _beginAnimation,
              _endAnimation,
              curve: Curves.easeIn,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: _theme.accentColor,
            shape: BoxShape.circle,
          ),
          width: _circleWidth,
        ),
      ),
    );
  }
}
