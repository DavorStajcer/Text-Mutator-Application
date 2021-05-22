import '../result_presentation/data/enteties/result_model.dart';
import '../text_load/data/enteties/text_model.dart';

abstract class DatabaseSource {
  Future<Map<String, dynamic>> fetchText(String id);
  Future<void> saveText(TextModel textModel);

  Future<List<Map<String, dynamic>>> fetchResults();
  Future<void> saveResult(ResultModel resultModel);
}
