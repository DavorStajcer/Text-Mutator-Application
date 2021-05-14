import 'package:flutter/material.dart';
import 'package:text_mutator/core/constants/pages.dart';
import 'package:text_mutator/functions/home/view/pages/home_page.dart';
import 'package:text_mutator/functions/mutation_flow_managment/view/pages/mutation_flow_page.dart';

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ROUTE_HOME_PAGE:
      return MaterialPageRoute(builder: (_) => HomePage());
    case ROUTE_RESULTS_PAGE:
      return MaterialPageRoute(builder: (_) => HomePage());
    case ROUTE_MUTATION_FLOW_PAGE:
      return MaterialPageRoute(builder: (_) => MutationFlowPage());
    default:
      return MaterialPageRoute(builder: (_) => HomePage());
  }
}
