import 'package:text_mutator/functions/text_input_and_load/domain/models/text.dart';

class TextModel extends Text {
  TextModel(
    String? text,
    String? name,
    String? id,
  ) : super(id: id, name: name, text: text);

  factory TextModel.fromJson(Map<String, dynamic> map) {
    return TextModel(map['text'], map['name'], map['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'text': this.text,
      'name': this.name,
      'id': this.id,
    };
  }
}
