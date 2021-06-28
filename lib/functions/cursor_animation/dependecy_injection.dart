import 'package:get_it/get_it.dart';
import 'package:text_mutator/functions/cursor_animation/mouse_cursor_bloc/mouse_cursor_bloc.dart';

void initiDependenciesMouseCursor() {
  final _get = GetIt.instance;

  _get.registerFactory(() => MouseCursorBloc());
}
