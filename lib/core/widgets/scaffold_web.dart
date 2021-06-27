import 'package:flutter/material.dart';
import 'package:text_mutator/core/constants/pages.dart';
import 'package:text_mutator/core/navigation/route_generation.dart';

class ScaffoldWeb extends StatelessWidget {
  const ScaffoldWeb({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    return Scaffold(
      drawerEnableOpenDragGesture: false,
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
        title: Text("MUTEXT"),
        backgroundColor: _theme.primaryColor,
      ),
      backgroundColor: _theme.primaryColor,
      body: Navigator(
        initialRoute: ROUTE_HOME_PAGE,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
