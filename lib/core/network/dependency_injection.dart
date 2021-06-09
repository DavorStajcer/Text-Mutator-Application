import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:text_mutator/core/authentication/signed_user_provider.dart';
import 'connection_checker.dart';
import 'package:http/http.dart' as http;

void initiDependenciesCoreNetwork() {
  final _get = GetIt.instance;

  _get.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  _get.registerLazySingleton<ConnectionChecker>(
      () => ConnectionCheckerImpl(_get()));

  _get.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  _get.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  _get.registerLazySingleton<http.Client>(() => http.Client());

  _get.registerLazySingleton<SignedUserProvider>(
      () => SignedUserProviderImpl(_get(), _get()));
}
