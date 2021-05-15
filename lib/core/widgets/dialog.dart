import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:text_mutator/core/widgets/app_button.dart';

void showNotificationDialog(
    BuildContext context, String text, ThemeData theme) {
  showDialog(
    context: context,
    builder: (ctx) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      // actions: [
      //   AppButton(text: 'Okay', onTap: () => Navigator.of(context).pop())
      // ],
      child: Container(
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 3,
            color: theme.textTheme.bodyText1!.color!,
          ),
        ),
        constraints: BoxConstraints.loose(Size(200, 200)),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: AutoSizeText(
                    text.isEmpty ? 'Entered text is emtpy.' : text,
                    style: theme.textTheme.bodyText1!,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: AppButton(
                text: 'Okay',
                onTap: () => Navigator.of(context).pop(),
                widthSizeFactor: 2.8,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
