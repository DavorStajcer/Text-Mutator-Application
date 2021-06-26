import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:text_mutator/functions/user_data_retrieval/view/pages/username_input_page.dart';
import 'functions/user_data_retrieval/view/pages/welcome_page.dart';
import 'functions/authenticating_user/view/auth_bloc/auth_bloc_bloc.dart';
import 'functions/authenticating_user/view/pages/authetication_page.dart';
import 'functions/authetication_checker/view/authentication_checker_bloc/authentication_checker_bloc.dart';
import 'dependency_injection.dart';
import 'functions/authetication_checker/view/authetication_action_cubit/authentication_action_cubit.dart';
import 'functions/result_presentation/view/blocs/results_difficulty_representation_cubit/results_difficulty_representation_cubit.dart';
import 'functions/result_presentation/view/blocs/results_graph_bloc/results_graph_bloc.dart';
import 'functions/text_mutation/view/mutate_bloc/mutate_bloc.dart';
import 'functions/theme_managment/cubit/theme_changing_cubit.dart';

import 'core/navigation/route_generation.dart';
import 'functions/result_presentation/view/blocs/result_bloc/result_bloc.dart';
import 'functions/user_data_retrieval/view/user_data_bloc/user_data_bloc.dart';
import 'functions/user_data_retrieval/view/user_data_validator_cubit/user_data_validator_cubit.dart';

// flutter run -d chrome --web-renderer canvaskit
// flutter build web --web-renderer canvaskit --release

//flutter run -d chrome --web-renderer canvaskit --web-hostname localhost --web-port 7357

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // final _app = await Firebase.initializeApp();

  // log(_app.toString());

  runApp(MyApp());
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyCFkAIiPvjUB-TKzVW1_7a6kc1uJn4GnrM",
            appId: "1:978003045031:web:33923d84ce80899d20c982",
            messagingSenderId: "978003045031",
            projectId: "focus-app-a06cb",
          ),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            log('DONE LOADING!');
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Mutext',
              //onGenerateRoute: onGenerateRoute,
              home: Scaffold(
                backgroundColor: Colors.green,
                body: Container(
                  child: Center(
                    child: Text(
                        ' IHFGUIFHG UGH RGUR GURG RG RUGNB REUGNER UGNR GURE NGEURNG REUNG REUGNRE UGNER GR'),
                  ),
                ),
              ),
            );
          }
          log('LOADING....');
          return Container();
        });
  }
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
              BlocProvider(
                create: (context) => GetIt.I<AuthenticationActionCubit>(),
              ),
              BlocProvider(
                create: (context) => GetIt.I<AuthenticationCheckerBloc>(),
              ),
              BlocProvider(
                create: (context) => GetIt.I<UserDataValidatorCubit>(),
              ),
              BlocProvider(
                create: (context) => GetIt.I<UserDataBloc>(),
              ),
              BlocProvider(
                create: (context) => GetIt.I<AuthBloc>(),
              ),
              BlocProvider(
                create: (context) => GetIt.I<ResultsGraphBloc>(),
              ),
              BlocProvider(
                create: (context) =>
                    GetIt.I<ResultsDifficultyRepresentationCubit>(),
              ),
            ],
            child: BlocBuilder<ThemeChangingCubit, ThemeChangingState>(
              builder: (context, themeState) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Mutext',
                  theme: themeState.theme,
                  onGenerateRoute: onGenerateRoute,
                  home: BlocBuilder<AuthenticationCheckerBloc,
                      AuthenticationCheckerState>(
                    builder: (context, state) {
                      log('auth state:    ' + state.toString());
                      if (state is UserAuthenticated) {
                        BlocProvider.of<UserDataBloc>(context)
                            .add(LoadUserData());
                        return UsernameInputPage();
                      }
                      if (state is UserNotAuthenticated) {
                        return AuthenticationPage();
                      }
                      return Scaffold(
                        backgroundColor: themeState.theme.primaryColor,
                        body: Container(),
                      );
                    },
                  ),
                );
              },
            ),
          );
        });
  }
}
