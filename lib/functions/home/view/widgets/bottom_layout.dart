import 'package:flutter/material.dart';

class BottomLayout extends StatelessWidget {
  const BottomLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Image.asset(
          'assets/png/lady.png',
          fit: BoxFit.fitWidth,
          frameBuilder: (BuildContext context, Widget child, int? frame,
              bool wasSynchronouslyLoaded) {
            return AnimatedOpacity(
              duration: Duration(milliseconds: 1000),
              opacity: frame == null ? 0 : 1,
              child: child,
            );
          },
        ),
      ],
    );
  }
}
