import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/functions/cursor_animation/mouse_cursor_bloc/mouse_cursor_bloc.dart';

class AppButtonWeb extends StatefulWidget {
  const AppButtonWeb({
    Key? key,
    required this.text,
    required this.autoSizeGroup,
    required this.textStyle,
  }) : super(key: key);

  final String text;
  final AutoSizeGroup? autoSizeGroup;
  final TextStyle textStyle;

  @override
  _AppButtonWebState createState() => _AppButtonWebState();
}

class _AppButtonWebState extends State<AppButtonWeb> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final MouseCursorBloc _mouseCursorBloc =
        BlocProvider.of<MouseCursorBloc>(context);

    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      transform: Matrix4.identity()
        ..scale((_isHovered ? 1.2 : 1), (_isHovered ? 1.2 : 1))
        ..translate((_isHovered ? -10 : 0)),
      child: MouseRegion(
        cursor: SystemMouseCursors.none,
        onEnter: (e) => _mouseRegionEntered(_mouseCursorBloc),
        onExit: (e) => _mouseRegionExited(_mouseCursorBloc),
        child: LayoutBuilder(builder: (ctx, contraints) {
          return Container(
            constraints: BoxConstraints(
              maxWidth: 400,
            ),
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.all(
                //   Radius.circular(60),
                // ),
                // border: Border.all(
                //   color: _theme.accentColor,
                //   width: 3,
                // ),
                ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: AutoSizeText(
                widget.text,
                maxLines: 1,
                textAlign: TextAlign.center,
                group: widget.autoSizeGroup,
                style: widget.textStyle,
              ),
            ),
          );
        }),
      ),
    );
  }

  void _mouseRegionEntered(MouseCursorBloc _mouseCursorBloc) {
    _mouseCursorBloc.add(
      MouseCursorSzeChanged(
        isCursorExpanded: true,
      ),
    );
    setState(() {
      _isHovered = true;
    });
  }

  void _mouseRegionExited(MouseCursorBloc _mouseCursorBloc) {
    _mouseCursorBloc.add(
      MouseCursorSzeChanged(
        isCursorExpanded: false,
      ),
    );
    setState(() {
      _isHovered = false;
    });
  }
}
