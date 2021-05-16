import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:text_mutator/dependency_injection.dart';
import 'package:text_mutator/functions/text_mutation/view/mutate_bloc/mutate_bloc.dart';
import 'package:text_mutator/functions/theme_managment/cubit/theme_changing_cubit.dart';

import 'core/navigation/route_generation.dart';
import 'functions/result_presentation/view/result_bloc/result_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: DependencyInjector.initiDependencies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container();
          }
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => GetIt.I<ThemeChangingCubit>(),
              ),
              BlocProvider(
                create: (context) => GetIt.I<MutateBloc>(),
              ),
              BlocProvider(
                create: (context) => GetIt.I<ResultBloc>(),
              ),
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
        });
  }
}
