import 'package:text_mutator/functions/text_mutation/domain/models/word/word.dart';

class CleanWord extends Word {
  CleanWord({required String word, required int index})
      : super(word, index, false);

  @override
  List<Object?> get props => [word, index];
}
