import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum_web/home_pages/home_page.dart';
import 'package:nam_ip_museum_web/translation_messages.dart';
import 'package:nam_ip_museum_web/utils/my_shared_preferences.dart';

import 'utils/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MySharedPreferences.init();
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