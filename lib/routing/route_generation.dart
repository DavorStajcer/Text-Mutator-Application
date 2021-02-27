import 'package:flutter/material.dart';
import 'package:text_mutator/presentation/clean_text_page/clean_text_page.dart';
import 'package:text_mutator/presentation/mutated_text_page/mutated_text_page.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/mutatedScreen':
      return MaterialPageRoute(builder: (_) => MutatedTextPage());
      break;
    case '/cleanScreen':
      return MaterialPageRoute(builder: (_) => CleanTextPage());
      break;
    default:
  }
}
