import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/core/constants/pages.dart';
import 'package:text_mutator/functions/mutation_flow_managment/view/progress_animation_cubit/progress_animation_cubit.dart';

class BottomPageNavigator extends StatelessWidget {
  final Size deviceSize;
  final PageController pageController;
  const BottomPageNavigator({
    Key? key,
    required this.deviceSize,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final ProgressAnimationCubit _progressAnimationCubit =
        BlocProvider.of<ProgressAnimationCubit>(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 8, 50, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              final _currState = _progressAnimationCubit.state;
              if (_currState.value == 0)
                Navigator.of(context).pushReplacementNamed(ROUTE_HOME_PAGE);
              else {
                pageController.animateToPage(_currState.value - 1,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeOut);

                _progressAnimationCubit.pageChanged(_currState.value - 1);
              }
            },
            child: AutoSizeText(
              '<- Back',
              style: _theme.textTheme.headline3,
            ),
          ),
          GestureDetector(
            onTap: () {
              final _currState = _progressAnimationCubit.state;
              if (_currState.value == 3)
                Navigator.of(context).pushReplacementNamed(ROUTE_HOME_PAGE);
              else {
                pageController.animateToPage(_currState.value + 1,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeOut);

                _progressAnimationCubit.pageChanged(_currState.value + 1);
              }
            },
            child: AutoSizeText(
              'Next ->',
              style: _theme.textTheme.headline3!
                  .copyWith(color: _theme.accentColor),
            ),
          ),
        ],
      ),
    );
  }
}
