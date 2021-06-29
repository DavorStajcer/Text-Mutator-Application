import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_button_web.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.autoSizeGroup,
    this.widthSizeFactor = 2.2,
    this.isAvailable = true,
    this.includeTopMaring = true,
    this.textStyle,
  }) : super(key: key);

  final String text;
  final Function() onTap;
  final AutoSizeGroup? autoSizeGroup;
  final double widthSizeFactor;
  final bool isAvailable;
  final bool includeTopMaring;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _deviceSize = MediaQuery.of(context).size;

    final Color _buttonColor =
        isAvailable ? _theme.accentColor : _theme.accentColor.withAlpha(100);

    final TextStyle _textStyle = textStyle ??
        _theme.textTheme.bodyText1!.copyWith(
          color: _buttonColor,
          fontWeight: FontWeight.w800,
        );

    return GestureDetector(
      onTap: onTap,
      child: kIsWeb
          ? _buildWeb(_deviceSize, _textStyle)
          : _buildMobile(_deviceSize, _buttonColor, _textStyle),
    );
  }

  Widget _buildWeb(Size _deviceSize, TextStyle _textStyle) {
    return AppButtonWeb(
      text: text,
      autoSizeGroup: autoSizeGroup,
      textStyle: _textStyle,
    );
  }

  Widget _buildMobile(
      Size _deviceSize, Color _buttonColor, TextStyle _textStyle) {
    return Container(
      width: _deviceSize.width / widthSizeFactor,
      constraints: BoxConstraints(maxWidth: 200),
      margin: includeTopMaring ? EdgeInsets.only(top: 30) : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(60),
        ),
        border: Border.all(
          color: _buttonColor,
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
          style: _textStyle,
        ),
      ),
    );
  }
}
