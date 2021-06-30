import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/functions/cursor_animation/animated_pointer.dart';
import 'package:text_mutator/functions/cursor_animation/mouse_cursor_bloc/mouse_cursor_bloc.dart';

class ScaffoldWeb extends StatefulWidget {
  final Widget body;
  const ScaffoldWeb({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  _ScaffoldWebState createState() => _ScaffoldWebState();
}

class _ScaffoldWebState extends State<ScaffoldWeb>
    with SingleTickerProviderStateMixin {
  late final AnimationController pointerAnimationController;
  Offset? offset;

  @override
  void initState() {
    pointerAnimationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 100));

    super.initState();
  }

  @override
  void dispose() {
    pointerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _theme.primaryColor,
      body: MouseRegion(
        cursor: SystemMouseCursors.none,
        opaque: false,
        onHover: (pEvent) => setState(() {
          offset = pEvent.localPosition;
        }),
        onExit: (pEvent) => setState(() {
          offset = null;
        }),
        child: Stack(
          children: [
            widget.body,
            BlocListener<MouseCursorBloc, MouseCursorState>(
              listener: (context, state) {
                if (state.isCursorExpanded) {
                  pointerAnimationController.forward();
                } else {
                  pointerAnimationController.reverse();
                }
              },
              child: offset == null
                  ? Container()
                  : Stack(children: [
                      AnimatedBuilder(
                          animation: pointerAnimationController,
                          builder: (ctx, _) {
                            return AnimatedPointer(
                              pointerOffset: offset!,
                              pointerOffsetDuration:
                                  Duration(milliseconds: 400),
                              pointerRadius:
                                  30 + (100 * pointerAnimationController.value),
                            );
                          }),
                      AnimatedPointer(
                        pointerOffset: offset!,
                        pointerOffsetDuration: Duration(milliseconds: 100),
                        pointerRadius: 10,
                      ),
                    ]),
            ),
          ],
        ),
      ),
    );
  }
}
