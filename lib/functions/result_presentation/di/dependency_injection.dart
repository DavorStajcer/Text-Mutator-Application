import 'package:get_it/get_it.dart';
import 'package:text_mutator/functions/result_presentation/view/blocs/results_graph_bloc/results_graph_bloc.dart';

import '../data/datasources/network_data_source.dart';
import '../data/respositories/results_repository_impl.dart';
import '../domain/repositories/result_respository.dart';
import '../view/blocs/result_bloc/result_bloc.dart';

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
  _get.registerFactory(() => ResultsGraphBloc(_get()));
}
