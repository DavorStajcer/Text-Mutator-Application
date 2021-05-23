import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:text_mutator/functions/authenticating_user/view/pages/authetication_page.dart';
import 'package:text_mutator/functions/authetication_checker/view/authentication_checker_bloc/authentication_checker_bloc.dart';
import 'package:text_mutator/functions/home/view/pages/home_page.dart';
import 'package:text_mutator/functions/user_data_retrieval/view/pages/username_input_page.dart';
import 'dependency_injection.dart';
import 'functions/authetication_checker/view/authetication_action_cubit/authentication_action_cubit.dart';
import 'functions/text_mutation/view/mutate_bloc/mutate_bloc.dart';
import 'functions/theme_managment/cubit/theme_changing_cubit.dart';

import 'core/navigation/route_generation.dart';
import 'functions/result_presentation/view/result_bloc/result_bloc.dart';
import 'functions/user_data_retrieval/view/user_data_bloc/user_data_bloc.dart';
import 'functions/user_data_retrieval/view/user_data_validator_cubit/user_data_validator_cubit.dart';

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
            ],
            child: BlocBuilder<ThemeChangingCubit, ThemeChangingState>(
              builder: (context, themeState) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: themeState.theme,
                  onGenerateRoute: onGenerateRoute,
                  home: BlocBuilder<AuthenticationCheckerBloc,
                      AuthenticationCheckerState>(
                    builder: (context, state) {
                      log(state.toString());
                      if (state is UserAuthenticated) return HomePage();
                      if (state is UserNotAuthenticated)
                        return AuthenticationPage();
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
