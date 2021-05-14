part of 'progress_animation_cubit.dart';

abstract class ProgressAnimationState extends Equatable {
  final int value;
  final String stepName;
  const ProgressAnimationState(this.value, this.stepName);

  @override
  List<Object> get props => [value];
}

class ProgressAnimationInitial extends ProgressAnimationState {
  ProgressAnimationInitial(int value, String stepName) : super(value, stepName);
}

class ProgressAnimationChanged extends ProgressAnimationState {
  ProgressAnimationChanged(int value, String stepName) : super(value, stepName);
}
