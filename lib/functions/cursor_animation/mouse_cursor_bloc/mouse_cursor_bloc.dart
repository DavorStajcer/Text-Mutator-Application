import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'mouse_cursor_event.dart';
part 'mouse_cursor_state.dart';

class MouseCursorBloc extends Bloc<MouseCursorEvent, MouseCursorState> {
  MouseCursorBloc() : super(MouseCursorMoved(false));

  @override
  Stream<MouseCursorState> mapEventToState(
    MouseCursorEvent event,
  ) async* {
    if (event is MouseCursorSzeChanged)
      yield MouseCursorMoved(event.isCursorExpanded);
  }
}
