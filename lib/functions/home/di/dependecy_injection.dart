import 'package:get_it/get_it.dart';
import '../view/home_navigator_cubit/home_navigator_cubit.dart';

void initiDependenciesHome() {
  final _get = GetIt.instance;

//!blocs
  _get.registerFactory(() => HomeNavigatorCubit());
}
