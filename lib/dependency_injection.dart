import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_mutator/core/local_storage_manager/dependency_injection.dart';
import 'package:text_mutator/core/network/dependency_injection.dart';
import 'package:text_mutator/functions/authenticating_user/di/dependency_injection.dart';
import 'package:text_mutator/functions/authetication_checker/di/dependency_injection.dart';
import 'package:text_mutator/functions/home/di/dependecy_injection.dart';
import 'package:text_mutator/functions/how_it_works_insatructions/dependency_injection.dart';
import 'package:text_mutator/functions/mutation_flow_managment/di/dependency_injection.dart';
import 'package:text_mutator/functions/result_presentation/di/dependency_injection.dart';
import 'package:text_mutator/functions/text_evaluation/di/dependency_injection.dart';
import 'package:text_mutator/functions/text_load/di/dependency_injection.dart';
import 'package:text_mutator/functions/text_mutation/di/dependency_injection.dart';
import 'package:text_mutator/functions/theme_managment/di/dependency_injection.dart';

class DependencyInjector {
  static Future<void> initiDependencies() async {
    final SharedPreferences _sharedPreferencesInstance =
        await SharedPreferences.getInstance();

    _initializeAllDependencies(_sharedPreferencesInstance);
  }
}

void _initializeAllDependencies(SharedPreferences sharedPreferences) {
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
}
