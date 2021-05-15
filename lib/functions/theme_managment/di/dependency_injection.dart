import 'package:get_it/get_it.dart';
import 'package:text_mutator/functions/theme_managment/cubit/theme_changing_cubit.dart';

void initiDependenciesThemeManagment() {
  final _get = GetIt.instance;

//!blocs
  _get.registerFactory(() => ThemeChangingCubit(
        _get(),
      ));
}
