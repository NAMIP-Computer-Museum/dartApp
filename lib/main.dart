import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'home_pages/home_page.dart';
import 'translation_messages.dart';
import 'utils/my_shared_preferences.dart';
import 'utils/navigation_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MySharedPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: 'NAM-IP Museum',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      translations: TranslationMessages(),
      locale: const Locale('fr', ''),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
    );
  }
}
