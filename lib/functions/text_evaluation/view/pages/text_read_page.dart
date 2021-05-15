import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:text_mutator/core/widgets/app_button.dart';
import 'package:text_mutator/core/widgets/bottom_page_navitator.dart';

class TextReadPage extends StatelessWidget {
  const TextReadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _deviceSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Expanded(
          child: TextField(),
        ),
        Row(
          children: [
            AppButton(
              text: 'Load',
              onTap: () {},
            ),
            AppButton(
              text: 'Save',
              onTap: () {},
            ),
          ],
        ),
        BottomPageNavigator(
          proceedeOnTapFunction: () {},
          backOnTapFunction: () {},
          proceedWidget: AutoSizeText(
            'Next ->',
            style:
                _theme.textTheme.headline3!.copyWith(color: _theme.accentColor),
          ),
          deviceSize: _deviceSize,
        ),
      ],
    );
  }
}
