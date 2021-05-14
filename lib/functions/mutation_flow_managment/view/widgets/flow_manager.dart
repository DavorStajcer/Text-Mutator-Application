import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/functions/how_it_works_insatructions/view/instructions_cubit/instructions_cubit_cubit.dart';
import 'package:text_mutator/functions/how_it_works_insatructions/view/widgets/how_it_works_page.dart';
import 'package:text_mutator/functions/mutation_flow_managment/view/progress_animation_cubit/progress_animation_cubit.dart';
import 'package:text_mutator/functions/mutation_flow_managment/view/widgets/bottom_page_navitator.dart';
import 'package:text_mutator/functions/mutation_flow_managment/view/widgets/progress_indicator/progress_indicator.dart';
import 'package:text_mutator/functions/text_evaluation/view/pages/text_evaluation_page.dart';
import 'package:text_mutator/functions/text_evaluation/view/pages/text_read_page.dart';
import 'package:text_mutator/functions/text_load/view/pages/text_load_page.dart';

class FlowManager extends StatefulWidget {
  FlowManager({Key? key}) : super(key: key);

  @override
  _FlowManagerState createState() => _FlowManagerState();
}

class _FlowManagerState extends State<FlowManager> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _pagesToDisplay = [
    BlocProvider(
      create: (context) => InstructionsCubit(),
      child: HowItWorksPage(),
    ),
    TextLoadPage(),
    TextEvaluationPage(),
    TextReadPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _deviceSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Column(
        children: [
          BlocBuilder<ProgressAnimationCubit, ProgressAnimationState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  state.stepName,
                  style: _theme.textTheme.headline3,
                ),
              );
            },
          ),
          ProgressIndicatorWidget(
            deviceSize: _deviceSize,
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) => _pagesToDisplay[index],
            ),
          ),
          BottomPageNavigator(
            deviceSize: _deviceSize,
            pageController: _pageController,
          ),
        ],
      ),
    );
  }
}
