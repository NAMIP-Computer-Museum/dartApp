import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:nam_ip_museum/utils/my_shared_preferences.dart';
import 'package:nam_ip_museum/utils/navigation_service.dart';

import 'home_page.dart';

class AccessToApp extends StatefulWidget {

  const AccessToApp({Key? key}) : super(key: key);

  @override
  State<AccessToApp> createState() => _AccessToAppState();
}

class _AccessToAppState extends State<AccessToApp> with WidgetsBindingObserver{

  Location location = Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  String errorMsg = "";
  String mdpError = "";

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  Future<void> getLocation() async {
    if (MySharedPreferences.isAuthorized) {
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
    if (MySharedPreferences.isAuthorized) {
      return const HomePage();
    }
    if (errorMsg == "") {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (errorMsg == "not error") {
      if (goodLocation()) {
        return FutureBuilder(
          future: MySharedPreferences.authorized(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return const HomePage();
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        );
      } else {
        errorMsg = "Vous n'êtes pas localisé au musée de NAM-IP, merci de vous y rendre pour accéder à l'application ou de rentrer le mot de passe disponible au musée si cela provient d'une erreur";
        return _mdpWidget();
      }
    } else {
      return _mdpWidget();
    }
  }

  Widget _mdpWidget() {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
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
                  onPressed: () async {
                    if (_controller.text == "") {
                      setState(() {
                        mdpError = "Merci de rentrer le mot de passe disponible au musée";
                      });
                    } else if (_controller.text == "a") {
                      await MySharedPreferences.authorized();
                      setState(() {});
                      Navigator.of(NavigationService.getContext()).pushReplacement(MaterialPageRoute(builder: (context) => const HomePage()));
                    } else {
                      setState(() {
                        mdpError = "Le mot de passe est incorrect";
                      });
                    }
                  },
                  child: const Text('Valider'),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    WidgetsBinding.instance.addObserver(this);
                    startTimer();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Accès Limité', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool goodLocation() {
    return (_locationData.latitude! >= 50.461745 || _locationData.latitude! <= 50.464197) && (_locationData.longitude! >=  4.833089 || _locationData.longitude! <= 4.839180);
  }

  late Stopwatch watch;
  late Timer timer;

  void startTimer() {
    if (MySharedPreferences.premiumDuration.inMilliseconds > 0) {
      watch = Stopwatch();
      watch.start();
      timer = updateDuration();
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      setState(() {
        errorMsg = "Vous n'avez plus de demo gratuite, merci de vous rendre au musée pour accéder à l'application ou de rentrer le mot de passe";
      });
    }
  }

  Timer updateDuration() =>
      Timer.periodic(const Duration(milliseconds: 100), (Timer timer) async {
        if(watch.elapsedMilliseconds >= MySharedPreferences.premiumDuration.inMilliseconds) {
          await handleTimeout();
          timer.cancel();
        }
      });

  Future<void> handleTimeout() async {
    await MySharedPreferences.setDuration(MySharedPreferences.premiumDuration.inMilliseconds - watch.elapsedMilliseconds);
    Navigator.of(NavigationService.getContext()).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    const AccessToApp()), (Route<dynamic> route) => false);
  }

  @override
  void dispose() {
    super.dispose();
    if (MySharedPreferences.isAuthorized) {
      WidgetsBinding.instance.removeObserver(this);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;

    if (isBackground) {
      await MySharedPreferences.setDuration(MySharedPreferences.premiumDuration.inMilliseconds - watch.elapsedMilliseconds);
      watch.stop();
    } else {
      watch.start();
    }
  }
}
