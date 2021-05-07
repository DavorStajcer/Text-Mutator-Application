import 'package:text_mutator/functions/result_presentation/data/enteties/result_model.dart';

abstract class NetworkResultDataSource {
  Future<List<Map<String, dynamic>>> fetchResults();
  Future<void> saveResult(ResultModel resultModel);
}

class NetworkResultDataSourceImpl extends NetworkResultDataSource {
  @override
  Future<List<Map<String, dynamic>>> fetchResults() {
    // TODO: implement fetchResults
    throw UnimplementedError();
  }

  @override
  Future<void> saveResult(ResultModel resultModel) {
    // TODO: implement saveResult
    throw UnimplementedError();
  }
}
