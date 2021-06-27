import 'dart:developer';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:text_mutator/core/widgets/scaffold_web.dart';
import 'package:text_mutator/functions/user_data_retrieval/view/pages/username_input_page.dart';
import 'package:text_mutator/system_orientation_mixin.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyCFkAIiPvjUB-TKzVW1_7a6kc1uJn4GnrM",
        appId: "AIzaSyApIcUpISS5mMsrv3wfotRcWVmVfb2t8lk",
        messagingSenderId: "978003045031",
        projectId: "focus-app-a06cb",
      ),
    );
  }

  // log(_app.toString());

  runApp(DevicePreview(
    enabled: false, //!kReleaseMode,
    builder: (ctx) => MyApp(),
  ));
}

class MyApp extends StatelessWidget with PortraitModeMixin {
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
                  home: kIsWeb
                      ? _buildWebStart(themeState)
                      : _buildMobileStart(themeState),
                );
              },
            ),
          );
        });
  }

  Widget _buildWebStart(ThemeChangingState themeState) {
    return ScaffoldWeb();
  }

  Widget _buildMobileStart(ThemeChangingState themeState) {
    return BlocBuilder<AuthenticationCheckerBloc, AuthenticationCheckerState>(
      builder: (context, state) {
        log('auth state:    ' + state.toString());
        if (state is UserAuthenticated) {
          BlocProvider.of<UserDataBloc>(context).add(LoadUserData());
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
    );
  }
}
