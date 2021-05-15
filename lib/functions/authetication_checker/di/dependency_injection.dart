import 'package:get_it/get_it.dart';
import 'package:text_mutator/functions/authetication_checker/view/auth_form_bloc/auth_form_bloc.dart';

void initiDependenciesAuthenticationChecker() {
  final _get = GetIt.instance;

//!blocs
  _get.registerFactory(() => AuthFormBloc());
}
