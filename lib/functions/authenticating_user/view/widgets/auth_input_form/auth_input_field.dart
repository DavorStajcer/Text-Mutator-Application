import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  const AuthInputField({
    Key? key,
    required this.theme,
    required OutlineInputBorder? highlitedBorder,
    required OutlineInputBorder? normalBorder,
    required this.onChanged,
    required this.title,
    this.errorMessage,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
  })  : _highlitedBorder = highlitedBorder,
        _normalBorder = normalBorder,
        super(key: key);

  final ThemeData theme;
  final OutlineInputBorder? _highlitedBorder;
  final OutlineInputBorder? _normalBorder;
  final Function(String text) onChanged;
  final String title;
  final String? errorMessage;
  final bool obscureText;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                title,
                style: theme.textTheme.bodyText1,
                textAlign: TextAlign.left,
                maxLines: 1,
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: TextField(
              onChanged: onChanged,
              obscureText: obscureText,
              style: theme.textTheme.bodyText1!
                  .copyWith(color: theme.accentColor, wordSpacing: 1),
              decoration: InputDecoration(
                focusedBorder: _highlitedBorder,
                border: _normalBorder,
                enabledBorder: _normalBorder,
                errorText: errorMessage,
                focusColor: theme.accentColor,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              textInputAction: textInputAction,
            ),
          ),
        ],
      ),
    );
  }
}
