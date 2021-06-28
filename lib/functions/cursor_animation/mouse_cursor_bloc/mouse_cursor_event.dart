part of 'mouse_cursor_bloc.dart';

abstract class MouseCursorEvent extends Equatable {}

class MouseCursorSzeChanged extends MouseCursorEvent {
  final bool isCursorExpanded;
  MouseCursorSzeChanged({
    required this.isCursorExpanded,
  });

  @override
  List<Object> get props => [this.isCursorExpanded];
}
