import 'package:get_it/get_it.dart';
import 'package:text_mutator/functions/result_presentation/data/datasources/network_data_source.dart';
import 'package:text_mutator/functions/result_presentation/data/respositories/results_repository_impl.dart';
import 'package:text_mutator/functions/result_presentation/domain/repositories/result_respository.dart';
import 'package:text_mutator/functions/result_presentation/view/result_bloc/result_bloc.dart';

void initiDependenciesResultResporesentation() {
  final _get = GetIt.instance;

  //!repository/datasources

  _get.registerLazySingleton<ResultRepository>(() => ResultRepositoryImpl(
        _get(),
        _get(),
      ));

  _get.registerLazySingleton<NetworkResultDataSource>(
      () => NetworkResultDataSourceImpl(
            _get(),
            _get(),
          ));

//!blocs
  _get.registerFactory(() => ResultBloc(_get()));
}
