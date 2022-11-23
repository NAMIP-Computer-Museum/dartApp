import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum/favorites/favorites_page.dart';
import 'package:nam_ip_museum/games/games.dart';
import 'package:nam_ip_museum/informations/about_us.dart';
import 'package:nam_ip_museum/timeline/timeline_micro.dart';
import 'package:nam_ip_museum/videos/home_videos.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../informations/introduction.dart';
import '../rechercher/rechercher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/binaryBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: FittedBox(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Image.asset('assets/micro-mega-${Get.locale?.languageCode}.png', width: 0.75 * width, fit: BoxFit.fitWidth),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Get.updateLocale(const Locale('fr', ''));
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString('lang', 'fr');
                      },
                      child: Container(
                        width: 0.2 * width,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red.shade900,
                        ),
                        child: Image.asset('assets/france.png'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        Get.updateLocale(const Locale('nl', ''));
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString('lang', 'nl');
                      },
                      child: Container(
                        width: 0.2 * width,
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red.shade900,
                        ),
                        child: Image.asset('assets/netherlands.png'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () async {
                        Get.updateLocale(const Locale('en', ''));
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString('lang', 'en');
                      },
                      child: Container(
                        width: 0.2 * width,
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
                const SizedBox(height: 20),
                _button("introduction", const Introduction()),
                const SizedBox(height: 5),
                _button("rechercher", const Rechercher()),
                const SizedBox(height: 5),
                _button("ligne_du_temps", const TimelineMicro()),
                const SizedBox(height: 5),
                _button("videos", const HomeVideos()),
                const SizedBox(height: 5),
                _button("favoris", const FavoritePage()),
                const SizedBox(height: 5),
                _button("jeux", const Games()),
                const SizedBox(height: 5),
                _button("a_propos", const AboutUs()),
                const SizedBox(height: 10),
                Image.asset('assets/app-nam-ip-icon.png', width: 0.3 * width, fit: BoxFit.fitWidth),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _button(String text, Widget page) {
    return SizedBox(
      width: 0.5 * MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
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
