import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum/home_pages/access_to_app.dart';
import 'package:nam_ip_museum/translation_messages.dart';
import 'package:nam_ip_museum/utils/my_shared_preferences.dart';

import 'utils/navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await DBHelper.transformJsonInDbFile();
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
      home: const AccessToApp(),
    );
  }
}