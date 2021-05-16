import 'package:flutter/material.dart';
import 'package:text_mutator/core/constants/pages.dart';
import 'package:text_mutator/functions/home/view/pages/home_page.dart';
import 'package:text_mutator/functions/mutation_flow_managment/view/pages/mutation_flow_page.dart';
import 'package:text_mutator/functions/result_presentation/view/pages/result_finished_page.dart';
import 'package:text_mutator/functions/text_mutation/view/pages/mutated_text_page.dart';
import 'package:text_mutator/functions/text_mutation/view/pages/preview_page.dart';

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
    default:
      return MaterialPageRoute(builder: (_) => HomePage());
  }
}
