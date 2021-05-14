import 'package:flutter/material.dart';

class ProgressAnimatedBar extends StatelessWidget {
  const ProgressAnimatedBar({
    Key? key,
    required double circleWidth,
    required double maxWidth,
    required AnimationController animationController,
    required ThemeData theme,
  })   : _circleWidth = circleWidth,
        _theme = theme,
        _maxWidth = maxWidth,
        _animationController = animationController,
        super(key: key);

  final double _circleWidth;
  final double _maxWidth;
  final ThemeData _theme;
  final AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: _circleWidth / 2),
        child: AnimatedBuilder(
          animation: CurvedAnimation(
              parent: _animationController, curve: Curves.easeInExpo),
          builder: (ctx, _) => Container(
            height: 10,
            width: _maxWidth * _animationController.value,
            decoration: BoxDecoration(
                color: _theme.accentColor.withAlpha(255),
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),

        //),
      ),
    );
  }
}
