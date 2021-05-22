import 'package:get_it/get_it.dart';
import '../data/user_authenticator_impl.dart';
import '../domain/contracts/user_authenticator.dart';
import '../view/auth_bloc/auth_bloc_bloc.dart';

void initiDependenciesAuthenticatingUser() {
  final _get = GetIt.instance;

  _get.registerLazySingleton<UserAuthenticator>(() => UserAuthenticatorImpl(
        _get(),
        _get(),
      ));

//!blocs
  _get.registerFactory(() => AuthBloc(_get()));
}
