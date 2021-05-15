import 'package:get_it/get_it.dart';
import 'package:text_mutator/functions/mutation_flow_managment/view/progress_animation_cubit/progress_animation_cubit.dart';

void initiDependenciesMuatationFlowManagment() {
  final _get = GetIt.instance;

//!blocs
  _get.registerFactory(() => ProgressAnimationCubit());
}
