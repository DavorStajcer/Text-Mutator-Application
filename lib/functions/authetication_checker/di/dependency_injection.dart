import 'package:get_it/get_it.dart';
import 'package:text_mutator/functions/authetication_checker/view/authentication_checker_bloc/authentication_checker_bloc.dart';
import 'package:text_mutator/functions/authetication_checker/view/authetication_action_cubit/authentication_action_cubit.dart';
import '../view/auth_form_bloc/auth_form_bloc.dart';

void initiDependenciesAuthenticationChecker() {
  final _get = GetIt.instance;

//!blocs
  _get.registerFactory(() => AuthFormBloc());

  _get.registerFactory(() => AuthenticationActionCubit());

  _get.registerLazySingleton(() => AuthenticationCheckerBloc(_get()));
}
