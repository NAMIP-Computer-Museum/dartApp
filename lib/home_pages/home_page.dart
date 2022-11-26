import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum_web/feedback_form/form_complete.dart';
import 'package:nam_ip_museum_web/games/games.dart';
import 'package:nam_ip_museum_web/informations/about_us.dart';
import 'package:nam_ip_museum_web/quiz/quiz_difficulty.dart';
import 'package:nam_ip_museum_web/utils/my_shared_preferences.dart';
import 'package:nam_ip_museum_web/utils/widgets.dart';
import 'package:nam_ip_museum_web/videos/home_videos.dart';

import '../informations/introduction.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (kIsWeb) width = MediaQuery.of(context).size.height * 0.6;
    return Scaffold(
      body: Widgets.containerWithBinaryBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logoNAMIP.png', width: 0.7 * width, fit: BoxFit.fitWidth),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await MySharedPreferences.updateLang('fr');
                    },
                    child: Container(
                      width: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red.shade900,
                      ),
                      child: Image.asset('assets/france.png'),
                    ),
                  ),
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTap: () async {
                      await MySharedPreferences.updateLang('nl');
                    },
                    child: Container(
                      width: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red.shade900,
                      ),
                      child: Image.asset('assets/netherlands.png'),
                    ),
                  ),
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTap: () async {
                      await MySharedPreferences.updateLang('en');
                    },
                    child: Container(
                      width: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red.shade900,
                      ),
                      child: Image.asset('assets/united-kingdom.png'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              _button('introduction', const Introduction()),
              const SizedBox(height: 10),
              _button('videos', const HomeVideos()),
              const SizedBox(height: 10),
              _button('quiz', const QuizDifficulty()),
              const SizedBox(height: 10),
              _button('a_propos', const AboutUs()),
              const SizedBox(height: 10),
              _button('jeux', const Games()),
              const SizedBox(height: 10),
              _button('formulaire', const FormComplete()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(String text, Widget page) {
    return SizedBox(
      width: 300,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        child: Text(text.tr, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
      ),
    );
  }
}
