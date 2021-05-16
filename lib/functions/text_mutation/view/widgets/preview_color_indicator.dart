import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PreviewColorIndicator extends StatelessWidget {
  const PreviewColorIndicator({
    Key? key,
    required this.previewColor,
    required this.previewMeaning,
    required this.meaningTextStyle,
  }) : super(key: key);

  final Color previewColor;
  final String previewMeaning;
  final TextStyle meaningTextStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: AutoSizeText(
            previewMeaning,
            style: meaningTextStyle.copyWith(
              color: previewColor,
            ),
          ),
        ),
        Container(
          height: 35,
          width: 35,
          color: previewColor,
        )
      ],
    );
  }
}
