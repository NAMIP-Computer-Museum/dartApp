import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nam_ip_museum/utils/widgets.dart';
import '../informations/manual.dart';

class Introduction extends StatelessWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Widgets.containerWithBinaryBackground(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('titreIntroduction'.tr, style: const TextStyle(fontSize: 30, color: Colors.yellow, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('descriptionIntroduction'.tr, style: const TextStyle(fontSize: 20, color: Colors.white), textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.red.shade900,
                  border: const Border(top: BorderSide(color: Colors.white, width: 2)),
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Manual())),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: 0.5 * MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),
                      child: Center(child: Text('modeEmploi'.tr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                    ),
                  ),
                )
              )
            ],
          )
        ),
      ),
    );
  }
}
