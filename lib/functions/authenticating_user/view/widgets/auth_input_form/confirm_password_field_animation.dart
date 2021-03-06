import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ConfirmPasswordAnimatedField extends StatelessWidget {
  const ConfirmPasswordAnimatedField({
    Key? key,
    required this.child,
    required this.animationController,
  }) : super(key: key);

  final Widget child;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? _fadeTransition()
        : SizeTransition(
            sizeFactor: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: animationController,
                curve: Curves.easeOut,
                reverseCurve: Curves.easeIn,
              ),
            ),
            child: _fadeTransition(),
          );
  }

  FadeTransition _fadeTransition() {
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
        ),
      ),
      child: child,
      // ),
    );
  }
}
