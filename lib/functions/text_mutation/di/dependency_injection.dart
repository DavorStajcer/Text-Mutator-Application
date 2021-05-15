import 'package:get_it/get_it.dart';
import 'package:text_mutator/functions/text_mutation/data/datasources/network_data_source.dart';
import 'package:text_mutator/functions/text_mutation/data/repositories/mutated_text_repository_impl.dart';
import 'package:text_mutator/functions/text_mutation/domain/repositories/mutated_text_repository.dart';
import 'package:text_mutator/functions/text_mutation/view/mutate_bloc/mutate_bloc.dart';

void initiDependenciesTextMutation() {
  final _get = GetIt.instance;

  //!repository/datasources
  _get.registerLazySingleton<MutatedTextRepository>(
      () => MutatedTextRepositoryImpl(
            _get(),
            _get(),
            _get(),
          ));

  _get.registerLazySingleton<NetworkMutatedWordsSource>(
      () => NetworkMutatedWordsSourceImpl(_get()));

//!blocs
  _get.registerFactory(() => MutateBloc(
        _get(),
        _get(),
      ));
}
