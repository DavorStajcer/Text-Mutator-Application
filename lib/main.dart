import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/data/repositories/mutated_text_repository.dart';
import 'package:text_mutator/data/repositories/text_repository.dart';
import 'package:text_mutator/logic/mutate_bloc/mutate_bloc.dart';

import 'logic/text_bloc/text_bloc.dart';
import 'presentation/clean_text_page/clean_text_page.dart';
import 'routing/route_generation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TextBloc(TextRepository()),
        ),
        BlocProvider(
          create: (context) => MutateBloc(MutatedTextRepository(),
              BlocProvider.of<TextBloc>(context, listen: false)),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green,
          //) and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: CleanTextPage(),
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
