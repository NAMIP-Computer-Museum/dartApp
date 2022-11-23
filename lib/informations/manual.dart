import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/widgets.dart';

class Manual extends StatelessWidget {
  const Manual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: SingleChildScrollView(
        child: Container(
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
                  child: Text('titreModeEmploi'.tr, style: const TextStyle(fontSize: 30, color: Colors.yellow, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('descriptionModeEmploi'.tr, style: const TextStyle(fontSize: 20, color: Colors.white), textAlign: TextAlign.center),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}
