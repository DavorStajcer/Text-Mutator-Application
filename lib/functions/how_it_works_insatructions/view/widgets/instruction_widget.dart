import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../theme_managment/cubit/theme_changing_cubit.dart';

class InstructionWidget extends StatelessWidget {
  final String assetSvgPath;
  final String textInstruction;
  const InstructionWidget({
    Key? key,
    required this.assetSvgPath,
    required this.textInstruction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Column(
      children: [
        Flexible(
          flex: 3,
          child: BlocBuilder<ThemeChangingCubit, ThemeChangingState>(
            builder: (context, state) {
              return SvgPicture.asset(
                assetSvgPath,
                color: state.isLight ? Colors.black : Colors.blue,
              );
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
            child: AutoSizeText(
              textInstruction,
              textAlign: TextAlign.justify,
              style: _theme.textTheme.bodyText1,
            ),
          ),
        ),
      ],
    );
  }
}
