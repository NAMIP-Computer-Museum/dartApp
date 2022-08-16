import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NAM IP Museum'),
        backgroundColor: Colors.red.shade900,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 2
          )
        ),
      ),
      body: Container(
        height: double.infinity, //TODO vérifier qu'il n'y pas d'overflow
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/binaryBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('titreApropos'.tr, style: const TextStyle(fontSize: 30, color: Colors.yellow, fontWeight: FontWeight.bold)),
              ),
              Image.asset('assets/NAMIP.jpg'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('descriptionApropos'.tr, style: const TextStyle(fontSize: 20, color: Colors.white), textAlign: TextAlign.center),
              ),
            ],
          )
        ),
      ),
    );
  }
}
