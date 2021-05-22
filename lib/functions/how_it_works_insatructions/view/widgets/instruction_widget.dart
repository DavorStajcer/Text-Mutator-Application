import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'instruction_page_indicator.dart';

class InstructionWidget extends StatelessWidget {
  final String assetImagePath;
  final String textInstruction;
  const InstructionWidget({
    Key? key,
    required this.assetImagePath,
    required this.textInstruction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 3,
          child: Image.asset(assetImagePath),
        ),
        Flexible(
          flex: 1,
          child: AutoSizeText(textInstruction),
        ),
      ],
    );
  }
}
