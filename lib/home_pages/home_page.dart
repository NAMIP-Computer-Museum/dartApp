import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum/informations/about_us.dart';
import 'package:nam_ip_museum/quiz/quiz_difficulty.dart';
import 'package:nam_ip_museum/rechercher/qr_code_test.dart';
import 'package:nam_ip_museum/videos/home_videos.dart';

import '../informations/introduction.dart';
import '../timeline/timeline.dart';

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
      backgroundColor: Colors.red,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/binaryBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logoNAMIP.png', width: 0.7 * width, fit: BoxFit.fitWidth),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Get.updateLocale(const Locale('fr', '')),
                    child: Container(
                      width: 0.2 * width,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Image.asset('assets/france.png'),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red.shade900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => Get.updateLocale(const Locale('nl', '')),
                    child: Container(
                      width: 0.2 * width,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Image.asset('assets/netherlands.png'),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red.shade900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => Get.updateLocale(const Locale('en', '')),
                    child: Container(
                      width: 0.2 * width,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Image.asset('assets/united-kingdom.png'),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red.shade900,
                      ),
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
                  child: Text('introduction'.tr, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 0.5 * width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const QrCodeTest()));
                  },
                  child: Text('rechercher'.tr, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 0.5 * width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyTimeline()));
                  },
                  child: Text('ligne_du_temps'.tr, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 0.5 * width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeVideos()));
                  },
                  child: Text('videos'.tr, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 0.5 * width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuizzDificulty()));
                  },
                  child: Text('quiz'.tr, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 0.5 * width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutUs()));
                  },
                  child: Text('a_propos'.tr, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
