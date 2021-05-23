import 'package:get_it/get_it.dart';
import 'package:text_mutator/functions/user_data_retrieval/data/datasources/user_local_datasource.dart';
import 'package:text_mutator/functions/user_data_retrieval/data/datasources/user_web_datasource.dart';
import 'package:text_mutator/functions/user_data_retrieval/data/repositories/user_repository_impl.dart';
import 'package:text_mutator/functions/user_data_retrieval/data/user_data_retriver_impl.dart';
import 'package:text_mutator/functions/user_data_retrieval/data/user_data_validator_impl.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/repositories/user_repository.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/user_data_retriever.dart';
import 'package:text_mutator/functions/user_data_retrieval/domain/user_data_validator.dart';
import 'package:text_mutator/functions/user_data_retrieval/view/user_data_bloc/user_data_bloc.dart';
import 'package:text_mutator/functions/user_data_retrieval/view/user_data_validator_cubit/user_data_validator_cubit.dart';

void initiDependenciesUserDataRetrieval() {
  final _get = GetIt.instance;

  //!datasources

  _get.registerLazySingleton<UserWebDataSource>(
      () => UserWebDataSource(_get(), _get()));
  _get.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSource(_get()));

  //!repositories/services
  _get.registerLazySingleton<UserDataRetriver>(
      () => UserDataRetriverImpl(_get(), _get(), _get()));
  _get.registerLazySingleton<UserDataRepository>(
      () => UserRepositoryImpl(_get(), _get()));
  _get.registerLazySingleton<UserDataValidator>(() => UserDataValidatorImpl());

//!blocs
  _get.registerFactory(() => UserDataBloc(_get()));

  _get.registerFactory(() => UserDataValidatorCubit(_get()));
}
