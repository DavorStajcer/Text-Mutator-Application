import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../progress_animation_cubit/progress_animation_cubit.dart';
import '../widgets/flow_manager.dart';
import '../../../text_evaluation/view/text_evaluation_bloc/textevaluation_bloc.dart';
import '../../../text_load/view/text_load_bloc/text_bloc.dart';
import '../../../text_load/view/text_validation_bloc/textvalidator_bloc.dart';

class MutationFlowPage extends StatelessWidget {
  const MutationFlowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I<ProgressAnimationCubit>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<TextValidatorBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<TextBloc>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<TextEvaluationBloc>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: _theme.primaryColor,
        body: FlowManager(),
      ),
    );
  }
}
