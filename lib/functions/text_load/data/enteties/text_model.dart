import '../../../../core/constants/enums.dart';
import '../../domain/models/text.dart';

class TextModel extends Text {
  TextModel(
    String text,
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
      map['id'],
      // TextDifficulty.values[map['textDifficulty']]
      TextDifficulty.Easy,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': this.text,
      'textDifficulty': this.textDifficulty.index,
    };
  }
}
