import 'package:get_it/get_it.dart';
import 'package:text_mutator/functions/authenticating_user/data/user_authenticator_impl.dart';
import 'package:text_mutator/functions/authenticating_user/domain/contracts/user_authenticator.dart';
import 'package:text_mutator/functions/authenticating_user/view/auth_bloc/auth_bloc_bloc.dart';

void initiDependenciesAuthenticatingUser() {
  final _get = GetIt.instance;

  _get.registerLazySingleton<UserAuthenticator>(() => UserAuthenticatorImpl(
        _get(),
        _get(),
      ));

//!blocs
  _get.registerFactory(() => AuthBloc(_get()));
}
