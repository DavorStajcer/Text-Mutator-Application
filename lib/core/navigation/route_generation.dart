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
      return MaterialPageRoute(builder: (_) => HomePage());
    case ROUTE_RESULTS_PAGE:
      return MaterialPageRoute(builder: (_) => HomePage());
    case ROUTE_MUTATION_FLOW_PAGE:
      return MaterialPageRoute(builder: (_) => MutationFlowPage());
    case ROUTE_MUTATED_TEXT_PAGE:
      return MaterialPageRoute(builder: (_) => MutatedTextPage());
    case ROUTE_RESULT_FINISHED_PAGE:
      return MaterialPageRoute(builder: (_) => ResultFinishedPage());
    case ROUTE_RESULT_PREVIEW_PAGE:
      return MaterialPageRoute(builder: (_) => PreviewPage());
    case ROUTE_USER_RESULTS_PREVIEW_PAGE:
      return MaterialPageRoute(builder: (_) => UserResultsPreviewPage());
    case ROUTE_AUTHENTICATION_PAGE:
      return MaterialPageRoute(builder: (_) => AuthenticationPage());
    case ROUTE_USERNAME_INPUT_PAGE:
      return MaterialPageRoute(builder: (_) => UsernameInputPage());
    case ROUTE_WELCOME_PAGE:
      return MaterialPageRoute(builder: (_) => WelcomePage());
    default:
      return MaterialPageRoute(builder: (_) => HomePage());
  }
}
