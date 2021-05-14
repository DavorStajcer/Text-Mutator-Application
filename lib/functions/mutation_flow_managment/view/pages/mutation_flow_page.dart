import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/functions/mutation_flow_managment/view/progress_animation_cubit/progress_animation_cubit.dart';
import 'package:text_mutator/functions/mutation_flow_managment/view/widgets/flow_manager.dart';

class MutationFlowPage extends StatelessWidget {
  const MutationFlowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return BlocProvider(
      create: (context) => ProgressAnimationCubit(),
      child: Scaffold(
        backgroundColor: _theme.primaryColor,
        body: FlowManager(),
      ),
    );
  }
}
