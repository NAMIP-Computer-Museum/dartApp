import 'package:flutter/material.dart';
import 'package:nam_ip_museum_web/utils/widgets.dart';

import '../home_pages/home_page.dart';

class FormComplete extends StatelessWidget {
  const FormComplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.appBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Votre réponse a bien été enregistrée.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 30),
            const Text("Merci d'avoir rempli le formulaire", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                const HomePage()), (Route<dynamic> route) => false),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.shade900,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("Retour à l'accueil", style: TextStyle(color: Colors.white, fontSize: 20),),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
