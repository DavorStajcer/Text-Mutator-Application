import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_mutator/core/local_storage_manager/local_storage_manager.dart';
import 'package:text_mutator/core/network/connection_checker.dart';
import 'package:text_mutator/functions/text_mutation/data/datasources/network_data_source.dart';
import 'package:text_mutator/functions/text_mutation/data/repositories/mutated_text_repository_impl.dart';
import 'package:text_mutator/functions/text_mutation/view/mutate_bloc/mutate_bloc.dart';
import 'package:text_mutator/functions/theme_managment/cubit/theme_changing_cubit.dart';

import 'core/navigation/route_generation.dart';
import 'functions/text_load/data/datasources/network_data_source.dart';
import 'functions/text_load/data/respositories/text_repository_impl.dart';
import 'functions/text_load/view/text_load_bloc/text_bloc.dart';

import 'package:http/http.dart' as http;

//TODO: DO DEPENDENCY INJECTION FOR ALL FUNCTIONS

late final SharedPreferences _sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TextBloc(TextRepositoryImpl(
            ConnectionCheckerImpl(),
            NetworkTextDataSourceImpl(
                FirebaseFirestore.instance, FirebaseAuth.instance),
          )),
        ),
        BlocProvider(
          create: (_) => ThemeChangingCubit(
            LocalStorageManagerImpl(
              _sharedPreferences,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => MutateBloc(
              MutatedTextRepositoryImpl(
                ConnectionCheckerImpl(),
                NetworkMutatedWordsSourceImpl(http.Client()),
                Random(),
              ),
              TextRepositoryImpl(
                ConnectionCheckerImpl(),
                NetworkTextDataSourceImpl(
                    FirebaseFirestore.instance, FirebaseAuth.instance),
              )),
        )
      ],
      child: BlocBuilder<ThemeChangingCubit, ThemeChangingState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: state.theme,
            onGenerateRoute: onGenerateRoute,
          );
        },
      ),
    );
  }
}
