import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.autoSizeGroup,
    this.widthSizeFactor = 2.2,
  }) : super(key: key);

  final String text;
  final Function() onTap;
  final AutoSizeGroup? autoSizeGroup;
  final double widthSizeFactor;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _deviceSize.width / widthSizeFactor,
        margin: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(60),
          ),
          border: Border.all(
            color: _theme.accentColor,
            width: 3,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: AutoSizeText(
            text,
            maxLines: 1,
            textAlign: TextAlign.center,
            group: autoSizeGroup,
            style: _theme.textTheme.bodyText1!.copyWith(
                color: _theme.accentColor, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}
