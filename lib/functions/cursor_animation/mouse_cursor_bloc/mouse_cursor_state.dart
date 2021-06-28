part of 'mouse_cursor_bloc.dart';

abstract class MouseCursorState extends Equatable {
  final bool isCursorExpanded;
  const MouseCursorState(this.isCursorExpanded);

  @override
  List<Object?> get props => [isCursorExpanded];
}

class MouseCursorMoved extends MouseCursorState {
  MouseCursorMoved(bool isCursorExpanded) : super(isCursorExpanded);
}
