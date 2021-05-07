import 'package:text_mutator/functions/text_load/data/enteties/text_model.dart';

abstract class NetworkTextDataSource {
  Future<Map<String, dynamic>> fetchText(String id);
  Future<void> saveText(TextModel textModel);
}

class NetworkTextDataSourceImpl extends NetworkTextDataSource {
  @override
  Future<Map<String, dynamic>> fetchText(String id) {
    // TODO: implement fetchText
    throw UnimplementedError();
  }

  @override
  Future<void> saveText(TextModel textModel) {
    // TODO: implement saveText
    throw UnimplementedError();
  }
}
