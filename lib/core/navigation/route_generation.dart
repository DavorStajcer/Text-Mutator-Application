import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../functions/authenticating_user/view/pages/authetication_page.dart';
import '../../functions/home/view/pages/home_page.dart';
import '../../functions/mutation_flow_managment/view/pages/mutation_flow_page.dart';
import '../../functions/result_presentation/view/pages/result_finished_page.dart';
import '../../functions/result_presentation/view/pages/user_results_previw_page.dart';
import '../../functions/text_mutation/view/pages/mutated_text_page.dart';
import '../../functions/text_mutation/view/pages/preview_page.dart';
import '../../functions/user_data_retrieval/view/pages/username_input_page.dart';
import '../../functions/user_data_retrieval/view/pages/welcome_page.dart';
import '../constants/pages.dart';

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ROUTE_HOME_PAGE:
      return _createRoute(HomePage());
    // case ROUTE_RESULTS_PAGE:
    //   return _createRoute( HomePage());
    case ROUTE_MUTATION_FLOW_PAGE:
      return _createRoute(MutationFlowPage());
    case ROUTE_MUTATED_TEXT_PAGE:
      return _createRoute(MutatedTextPage());
    case ROUTE_RESULT_FINISHED_PAGE:
      return _createRoute(ResultFinishedPage());
    case ROUTE_RESULT_PREVIEW_PAGE:
      return _createRoute(PreviewPage());
    case ROUTE_USER_RESULTS_PREVIEW_PAGE:
      return _createRoute(UserResultsPreviewPage());
    case ROUTE_AUTHENTICATION_PAGE:
      return _createRoute(AuthenticationPage());
    case ROUTE_USERNAME_INPUT_PAGE:
      return _createRoute(UsernameInputPage());
    case ROUTE_WELCOME_PAGE:
      return _createRoute(WelcomePage());
    default:
      return _createRoute(HomePage());
  }
}

Route _createRoute(Widget child) {
  if (!kIsWeb) {
    return MaterialPageRoute(builder: (_) => child);
  }
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
