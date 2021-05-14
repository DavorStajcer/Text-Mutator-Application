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
        ),
      ],
    );
  }
}
