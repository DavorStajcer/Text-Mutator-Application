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

  void pageChanged(int pageIndex) =>
      emit(ProgressAnimationChanged(pageIndex, _pageStepNames[pageIndex]));
}
