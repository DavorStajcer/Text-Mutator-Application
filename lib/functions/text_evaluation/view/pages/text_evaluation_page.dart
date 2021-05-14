import 'package:flutter/material.dart';
import 'package:text_mutator/core/widgets/app_button.dart';

class TextEvaluationPage extends StatelessWidget {
  const TextEvaluationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      ],
    );
  }
}
