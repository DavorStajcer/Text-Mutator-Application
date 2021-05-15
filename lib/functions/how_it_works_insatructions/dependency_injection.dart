import 'package:get_it/get_it.dart';
import 'package:text_mutator/functions/how_it_works_insatructions/view/instructions_cubit/instructions_cubit_cubit.dart';

void initiDependenciesHowItWorksInstructions() {
  final _get = GetIt.instance;

//!blocs
  _get.registerFactory(() => InstructionsCubit());
}
