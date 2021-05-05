import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_mutator/functions/database/database.dart';
import 'package:text_mutator/functions/text_mutation/data/repositories/mutated_text_repository_impl.dart';
import 'package:text_mutator/functions/text_input_and_load/data/respositories/text_repository_impl.dart';
import 'package:text_mutator/functions/text_mutation/view/mutate_bloc/mutate_bloc.dart';

import 'functions/text_input_and_load/view/text_bloc/text_bloc.dart';
import 'functions/text_input_and_load/view/clean_text_page.dart';
import 'core/navigation/route_generation.dart';

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
          create: (context) => TextBloc(TextRepositoryImpl(DatabaseHelper())),
        ),
        BlocProvider(
          create: (context) => MutateBloc(
            MutatedTextRepositoryImpl(),
          ),
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
