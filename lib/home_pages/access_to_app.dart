import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class AccessToApp extends StatefulWidget {

  const AccessToApp({Key? key}) : super(key: key);

  @override
  State<AccessToApp> createState() => _AccessToAppState();
}

class _AccessToAppState extends State<AccessToApp> {

  Location location = Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  String errorMsg = "";
  String mdpError = "";

  late bool? isAuthorized;
  late final SharedPreferences prefs;
  bool isLoading = false;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  Future<void> getAuthorized() async {
    prefs = await SharedPreferences.getInstance();
    isAuthorized = prefs.getBool('isAuthorized');
    isAuthorized ??= false;
    setState(() {
      isLoading = true;
    });
  }

  Future<void> getLocation() async {
    await getAuthorized();
    if (isAuthorized!) {
      return;
    }
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        setState(() {
          errorMsg = "Le service de location rencontre un problème, merci de rentrer le mot de passe disponible au musée afin d'accéder à l'application";
        });
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        setState(() {
          errorMsg = "Vous n'avez pas autorisez l'accès à votre position, merci de rentrer le mot de passe disponible au musée afin d'accéder à l'application";
        });
        return;
      }
    }
    _locationData = await location.getLocation();
    setState(() {
      errorMsg = "not error";
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading && isAuthorized!) {
      return const HomePage();
    }
    if (errorMsg == "" || !isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (errorMsg == "not error") {
      if (goodLocation()) {
        setState(() {
          isAuthorized = true;
          prefs.setBool('isAuthorized', true);
        });
        return const HomePage();
      } else {
        errorMsg = "Vous n'êtes pas localisé au musée de NAM-IP, merci de vous y rendre pour accéder à l'application ou de rentrer le mot de passe disponible au musée si cela provient d'une erreur";
        return _mdpWidget();
      }
    } else {
      return Scaffold(
        body: Center(
          child: _mdpWidget(),
        ),
      );
    }
  }

  Widget _mdpWidget() {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/binaryBackground.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Get.updateLocale(const Locale('fr', '')),
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
                    onTap: () => Get.updateLocale(const Locale('nl', '')),
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
                    onTap: () => Get.updateLocale(const Locale('en', '')),
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
              Text(errorMsg, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white), textAlign: TextAlign.center),
              const SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter MDP',
                  border: const OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  errorText: mdpError,
                  errorStyle: mdpError == "" ? const TextStyle(fontSize: 0, color: Colors.red) : const TextStyle(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_controller.text == "") {
                    setState(() {
                      mdpError = "Merci de rentrer le mot de passe disponible au musée";
                    });
                  } else if (_controller.text == "a") {
                    setState(() {
                      mdpError = "";
                    });
                  } else {
                    setState(() {
                      mdpError = "Le mot de passe est incorrect";
                    });
                  }
                },
                child: const Text('Valider'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool goodLocation() {
    return (_locationData.latitude! >= 50.461745 || _locationData.latitude! <= 50.464197) && (_locationData.longitude! >=  4.833089 || _locationData.longitude! <= 4.839180);
  }
}
