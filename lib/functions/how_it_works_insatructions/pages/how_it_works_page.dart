import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/core/constants/pages.dart';
import 'package:text_mutator/core/constants/texts.dart';
import 'package:text_mutator/core/widgets/bottom_page_navitator.dart';
import 'package:text_mutator/functions/how_it_works_insatructions/view/instructions_cubit/instructions_cubit_cubit.dart';
import 'package:text_mutator/functions/how_it_works_insatructions/view/widgets/instruction_page_indicator.dart';
import 'package:text_mutator/functions/how_it_works_insatructions/view/widgets/instruction_widget.dart';
import 'package:text_mutator/functions/mutation_flow_managment/view/progress_animation_cubit/progress_animation_cubit.dart';

class HowItWorksPage extends StatefulWidget {
  const HowItWorksPage({Key? key}) : super(key: key);

  @override
  _HowItWorksPageState createState() => _HowItWorksPageState();
}

class _HowItWorksPageState extends State<HowItWorksPage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _deviceSize = MediaQuery.of(context).size;

    final ProgressAnimationCubit _progressAnimationCubit =
        BlocProvider.of<ProgressAnimationCubit>(context);

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            flex: 6,
            child: PageView(
              onPageChanged: (int currentPageIndex) =>
                  BlocProvider.of<InstructionsCubit>(context)
                      .changePage(currentPageIndex),
              children: [
                InstructionWidget(
                  assetImagePath: 'assets/png/lady.png',
                  textInstruction: TEXT_INSTRUCTION_LOAD_TEXT,
                ),
                InstructionWidget(
                  assetImagePath: 'assets/png/lady.png',
                  textInstruction: TEXT_INSTRUCTION_LOAD_TEXT,
                ),
                InstructionWidget(
                  assetImagePath: 'assets/png/lady.png',
                  textInstruction: TEXT_INSTRUCTION_LOAD_TEXT,
                ),
                InstructionWidget(
                  assetImagePath: 'assets/png/lady.png',
                  textInstruction: TEXT_INSTRUCTION_LOAD_TEXT,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: BlocBuilder<InstructionsCubit, InstructionsCubitState>(
              builder: (context, state) {
                return InstructionPageIndicator(
                  currentlyPreviewdPageIndex: state.instructionPageIndex,
                );
              },
            ),
          ),
          Spacer(),
          BottomPageNavigator(
            backOnTapFunction: () =>
                Navigator.of(context).pushReplacementNamed(ROUTE_HOME_PAGE),
            proceedeOnTapFunction: () => _progressAnimationCubit.pageForward(),
            proceedWidget: AutoSizeText(
              'Next ->',
              style: _theme.textTheme.headline3!
                  .copyWith(color: _theme.accentColor),
            ),
            deviceSize: _deviceSize,
          ),
        ],
      ),
    );
  }
}
