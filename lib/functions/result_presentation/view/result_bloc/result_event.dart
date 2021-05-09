part of 'result_bloc.dart';

@immutable
abstract class ResultEvent extends Equatable {
  const ResultEvent();
}

class CreateResult extends ResultEvent {
  final MutatedText mutatedText;
  const CreateResult(this.mutatedText);

  @override
  List<Object?> get props => [mutatedText];
}

class LoadResults extends ResultEvent {
  @override
  List<Object?> get props => [];
}

// class LoadText extends ResultEvent {
//   final List<SelectableTextWidget> allText;
//   const LoadText(this.allText);
// }


