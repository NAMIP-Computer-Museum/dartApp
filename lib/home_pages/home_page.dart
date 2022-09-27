import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum/favorites/favorites_page.dart';
import 'package:nam_ip_museum/informations/about_us.dart';
import 'package:nam_ip_museum/quiz/quiz_difficulty.dart';
import 'package:nam_ip_museum/timeline/home_timeline.dart';
import 'package:nam_ip_museum/utils/my_shared_preferences.dart';
import 'package:nam_ip_museum/videos/home_videos.dart';

import '../games/snake/snake.dart';
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/binaryBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logoNAMIP.png', width: 0.7 * width, fit: BoxFit.fitWidth),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await MySharedPreferences.updateLang('fr');
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
                        await MySharedPreferences.updateLang('nl');
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
                        await MySharedPreferences.updateLang('en');
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
                SizedBox(
                  width: 0.5 * width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Introduction()));
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text('introduction'.tr, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 0.5 * width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Rechercher()));
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text('rechercher'.tr, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 0.5 * width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeTimeline()));
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text('ligne_du_temps'.tr, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 0.5 * width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeVideos()));
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text('videos'.tr, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 0.5 * width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuizDifficulty()));
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text('quiz'.tr, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 0.5 * width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutUs()));
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text('a_propos'.tr, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 0.5 * width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FavoritePage()));
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text('favoris'.tr, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),

                const SizedBox(height: 5),
                SizedBox(
                  width: 0.5 * width,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Snake()));
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text('jeux'.tr, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
