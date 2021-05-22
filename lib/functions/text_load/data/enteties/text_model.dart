import '../../../../core/constants/enums.dart';
import '../../domain/models/text.dart';

class TextModel extends Text {
  TextModel(
    String text,
    // String name,
    String id,
    TextDifficulty textDifficulty,
  ) : super(
          id: id,
          text: text,
          textDifficulty: textDifficulty,
        );

  factory TextModel.fromJson(Map<String, dynamic> map) {
    return TextModel(
      map['text'],
      // map['name'],
      map['id'],
      TextDifficulty.values[map['textDifficulty']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': this.text,
      // 'name': this.name,
      // 'id': this.id,
      'textDifficulty': this.textDifficulty.index,
    };
  }
}
