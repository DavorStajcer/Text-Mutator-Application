import 'package:get_it/get_it.dart';

import 'view/instructions_cubit/instructions_cubit_cubit.dart';

void initiDependenciesHowItWorksInstructions() {
  final _get = GetIt.instance;

//!blocs
  _get.registerFactory(() => InstructionsCubit());
}
