import 'package:get_it/get_it.dart';

import '../data/datasources/network_data_source.dart';
import '../data/respositories/text_repository_impl.dart';
import '../domain/repsositories/text_repository.dart';
import '../view/text_load_bloc/text_bloc.dart';
import '../view/text_validation_bloc/text_validator.dart';
import '../view/text_validation_bloc/textvalidator_bloc.dart';

void initiDependenciesTextLoad() {
  final _get = GetIt.instance;

  //!repository/datasources

  _get.registerLazySingleton<TextRepository>(() => TextRepositoryImpl(
        _get(),
        _get(),
      ));

  _get.registerLazySingleton<NetworkTextDataSource>(
      () => NetworkTextDataSourceImpl(
            _get(),
            _get(),
          ));

  _get.registerLazySingleton<TextValidator>(
    () => TextValidatorImpl(),
  );

//!blocs
  _get.registerFactory(() => TextValidatorBloc(
        _get(),
      ));

  _get.registerFactory(() => TextBloc(
        _get(),
        _get(),
      ));
}
