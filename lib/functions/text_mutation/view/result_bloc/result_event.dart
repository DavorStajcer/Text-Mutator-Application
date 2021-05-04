part of 'result_bloc.dart';

@immutable
abstract class ResultEvent {
  const ResultEvent();
}

class CreateResult extends ResultEvent {
  final Text text;
  final List<SelectableTextWidget> allText;
  const CreateResult(this.allText, this.text);
}

// class LoadText extends ResultEvent {
//   final List<SelectableTextWidget> allText;
//   const LoadText(this.allText);
// }

class Restart extends ResultEvent {}

class AbandoneResult extends ResultEvent {}
