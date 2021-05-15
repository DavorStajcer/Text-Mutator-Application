import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'progress_animation_state.dart';

final List<String> _pageStepNames = [
  'How it works',
  'Choosing text',
  'Mutation settings',
  'Reading',
];

class ProgressAnimationCubit extends Cubit<ProgressAnimationState> {
  ProgressAnimationCubit()
      : super(ProgressAnimationInitial(0, _pageStepNames[0]));

  void pageBack() {
    if (state.value == 0)
      emit(ProgressAnimationChanged(0, _pageStepNames[0]));
    else
      emit(ProgressAnimationChanged(
          state.value - 1, _pageStepNames[state.value - 1]));
  }

  void pageForward() {
    if (state.value == 3)
      emit(ProgressAnimationChanged(3, _pageStepNames[3]));
    else
      emit(ProgressAnimationChanged(
          state.value + 1, _pageStepNames[state.value + 1]));
  }
}
