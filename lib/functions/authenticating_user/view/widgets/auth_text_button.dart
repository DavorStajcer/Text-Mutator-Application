import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AuthTextButton extends StatelessWidget {
  const AuthTextButton({
    Key? key,
    required this.text,
    required this.textStyle,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final TextStyle textStyle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AutoSizeText(
        text,
        style: textStyle,
        maxLines: 1,
      ),
    );
  }
}
