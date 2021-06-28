import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/core/constants/pages.dart';
import 'package:text_mutator/core/navigation/route_generation.dart';
import 'package:text_mutator/functions/cursor_animation/animated_pointer.dart';
import 'package:text_mutator/functions/cursor_animation/mouse_cursor_bloc/mouse_cursor_bloc.dart';
import 'package:text_mutator/functions/home/view/widgets/top_layout_theme_button.dart';

class ScaffoldWeb extends StatefulWidget {
  const ScaffoldWeb({
    Key? key,
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
      drawer: GestureDetector(
        onHorizontalDragUpdate: (_) => null,
        child: Row(
          children: [
            Drawer(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Home page'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Practice'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Results'),
                ),
              ]),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        //title: Text("MUTEXT"),
        backgroundColor: _theme.primaryColor,
        actions: [
          TopLayoutThemeButton(),
          SizedBox(
            width: 100,
          )
        ],
      ),
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
            Navigator(
              initialRoute: ROUTE_HOME_PAGE,
              onGenerateRoute: onGenerateRoute,
            ),
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
