part of 'result_bloc.dart';

@immutable
abstract class ResultEvent {
  const ResultEvent();
}

class CreateResult extends ResultEvent {
  final MutatedText mutatedText;
  const CreateResult(this.mutatedText);
}

// class LoadText extends ResultEvent {
//   final List<SelectableTextWidget> allText;
//   const LoadText(this.allText);
// }

class Restart extends ResultEvent {}

class AbandoneResult extends ResultEvent {}
