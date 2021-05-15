part of 'textvalidator_bloc.dart';

abstract class TextValidatorState extends Equatable {
  final String? text;
  const TextValidatorState(this.text);

  @override
  List<Object?> get props => [text];
}

class TextValidationInitial extends TextValidatorState {
  TextValidationInitial() : super('You have not entered any text.');
}

class TextNotValid extends TextValidatorState {
  TextNotValid(String text) : super(text);
}

class TextValid extends TextValidatorState {
  TextValid() : super(null);
}
