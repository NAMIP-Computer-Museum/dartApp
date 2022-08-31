import 'package:flutter/material.dart';
import 'package:nam_ip_museum/home_pages/access_to_app.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext getContext() {
    BuildContext context = StatefulElement(const AccessToApp());
    if (navigatorKey.currentContext != null) {
      context = navigatorKey.currentContext!;
    }
    return context;
  }
}