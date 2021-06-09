import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../data/user_authenticator_impl.dart';
import '../domain/contracts/user_authenticator.dart';
import '../view/auth_bloc/auth_bloc_bloc.dart';

void initiDependenciesAuthenticatingUser() {
  final _get = GetIt.instance;

  _get.registerLazySingleton<GoogleSignIn>(
    () => GoogleSignIn(
      scopes: [
        'email',
        'profile',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    ),
  );

  _get.registerLazySingleton<UserAuthenticator>(() => UserAuthenticatorImpl(
        _get(),
        _get(),
        _get(),
      ));

//!blocs
  _get.registerFactory(() => AuthBloc(_get()));
}
