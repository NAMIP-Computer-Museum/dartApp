import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum_web/utils/widgets.dart';

class Manual extends StatelessWidget {
  const Manual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: Widgets.containerWithBinaryBackground(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 70.0),
                child: Text('titreModeEmploi'.tr, style: const TextStyle(fontSize: 30, color: Colors.yellow, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 200.0),
                child: Text('descriptionModeEmploi'.tr, style: const TextStyle(fontSize: 20, color: Colors.white), textAlign: TextAlign.center),
              ),
            ],
          )
        ),
      ),
    );
  }
}
