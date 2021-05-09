import 'package:text_mutator/functions/text_mutation/domain/models/word/word.dart';

class MutatedWord extends Word {
  MutatedWord({required String word, required int index})
      : super(word, index, false);

  @override
  List<Object?> get props => [word, index];
}
