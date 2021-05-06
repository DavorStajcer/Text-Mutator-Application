import 'package:text_mutator/functions/text_mutation/domain/models/word/word.dart';

class MutatedWord extends Word {
  MutatedWord({String? word, int? index}) : super(word, index, false);

  @override
  // TODO: implement props
  List<Object?> get props => [word, index];
}
