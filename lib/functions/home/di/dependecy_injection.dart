import 'package:get_it/get_it.dart';
import 'package:text_mutator/functions/home/view/home_navigator_cubit/home_navigator_cubit.dart';

void initiDependenciesHome() {
  final _get = GetIt.instance;

//!blocs
  _get.registerFactory(() => HomeNavigatorCubit());
}
