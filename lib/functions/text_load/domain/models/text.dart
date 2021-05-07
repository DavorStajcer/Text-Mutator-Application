import 'package:equatable/equatable.dart';
import 'package:text_mutator/core/constants/enums.dart';

class Text extends Equatable {
  final String text;
  // final String name;
  final String id;
  late final TextDifficulty textDifficulty;
  Text({
    required this.text,
    // required this.name,
    required this.id,
    required this.textDifficulty,
  });

  Text.createDifficulty({
    required this.text,
    // required this.name,
    required this.id,
  }) {
    if (text.length < 400)
      this.textDifficulty = TextDifficulty.Easy;
    else if (text.length < 800)
      this.textDifficulty = TextDifficulty.Medium;
    else {
      this.textDifficulty = TextDifficulty.Hard;
    }
  }

  @override
  List<Object?> get props => [id, text, textDifficulty];
}
