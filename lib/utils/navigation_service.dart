import 'package:flutter/material.dart';

import '../home_pages/home_page.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext getContext() {
    BuildContext context = StatefulElement(const HomePage());
    if (navigatorKey.currentContext != null) {
      context = navigatorKey.currentContext!;
    }
    return context;
  }
}