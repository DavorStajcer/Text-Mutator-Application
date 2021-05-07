import 'package:flutter/material.dart';
import 'package:text_mutator/functions/text_load/view/clean_text_page.dart';
import 'package:text_mutator/functions/text_mutation/view/mutated_text_page.dart';

Route? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/mutatedScreen':
      return MaterialPageRoute(builder: (_) => MutatedTextPage());
    case '/cleanScreen':
      return MaterialPageRoute(builder: (_) => CleanTextPage());
    default:
      return MaterialPageRoute(builder: (_) => CleanTextPage());
  }
}
