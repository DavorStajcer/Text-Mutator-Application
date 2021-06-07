import 'package:get_it/get_it.dart';

import '../view/text_evaluation_bloc/textevaluation_bloc.dart';

void initiDependenciesTextEvaluation() {
  final _get = GetIt.instance;

//!blocs
  _get.registerFactory(() => TextEvaluationBloc());
}
