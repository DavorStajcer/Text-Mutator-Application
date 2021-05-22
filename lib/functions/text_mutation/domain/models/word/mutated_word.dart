import 'word.dart';

class MutatedWord extends Word {
  MutatedWord({required String word, required int index})
      : super(word, index, false);

  @override
  List<Object?> get props => [word, index];
}
