import 'package:get_it/get_it.dart';

import '../view/progress_animation_cubit/progress_animation_cubit.dart';

void initiDependenciesMuatationFlowManagment() {
  final _get = GetIt.instance;
//!blocs
  _get.registerFactory(() => ProgressAnimationCubit());
}
