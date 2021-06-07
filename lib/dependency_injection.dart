import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'functions/user_data_retrieval/di/dependency_injection.dart';
import 'core/local_storage_manager/dependency_injection.dart';
import 'core/network/dependency_injection.dart';
import 'functions/authenticating_user/di/dependency_injection.dart';
import 'functions/authetication_checker/di/dependency_injection.dart';
import 'functions/home/di/dependecy_injection.dart';
import 'functions/how_it_works_insatructions/dependency_injection.dart';
import 'functions/mutation_flow_managment/di/dependency_injection.dart';
import 'functions/result_presentation/di/dependency_injection.dart';
import 'functions/text_evaluation/di/dependency_injection.dart';
import 'functions/text_load/di/dependency_injection.dart';
import 'functions/text_mutation/di/dependency_injection.dart';
import 'functions/theme_managment/di/dependency_injection.dart';

class DependencyInjector {
  static Future<void> initiDependencies() async {
    final SharedPreferences _sharedPreferencesInstance =
        await SharedPreferences.getInstance();

    _initializeAllDependencies(_sharedPreferencesInstance);
  }
}

void _initializeAllDependencies(SharedPreferences sharedPreferences) {
  initiDependenciesUserDataRetrieval();
  initiDependenciesAuthenticatingUser();
  initiDependenciesAuthenticationChecker();
  initiDependenciesCoreLocalStorageManager(sharedPreferences);
  initiDependenciesCoreNetwork();
  initiDependenciesHome();
  initiDependenciesHowItWorksInstructions();
  initiDependenciesMuatationFlowManagment();
  initiDependenciesResultResporesentation();
  initiDependenciesTextEvaluation();
  initiDependenciesTextLoad();
  initiDependenciesTextMutation();
  initiDependenciesThemeManagment();
  GetIt.I.registerLazySingleton<Random>(() => Random());
}
