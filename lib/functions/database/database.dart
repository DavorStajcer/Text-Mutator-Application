import '../result_presentation/data/enteties/result_model.dart';
import '../text_load/data/enteties/text_model.dart';
import 'database_source.dart';

class DatabaseHelper extends DatabaseSource {
  @override
  Future<List<Map<String, dynamic>>> fetchResults() {
    // TODO: implement fetchResults
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> fetchText(String id) {
    // TODO: implement fetchText
    throw UnimplementedError();
  }

  @override
  Future<void> saveResult(ResultModel resultModel) {
    // TODO: implement saveResult
    throw UnimplementedError();
  }

  @override
  Future<void> saveText(TextModel textModel) {
    // TODO: implement saveext
    throw UnimplementedError();
  }
}
