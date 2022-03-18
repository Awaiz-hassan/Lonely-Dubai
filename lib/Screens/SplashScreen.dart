import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginScreen.dart';
import 'MainTabScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void toMainScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? logged = prefs.getBool('user_logged');
    if (logged != null) {
      if (logged) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainTabScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            child: Image.asset(
              "assets/images/splash.png",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                curve: Curves.ease,
                onEnd: () {
                  toMainScreen();
                },
                duration: const Duration(seconds: 3),
                builder: (BuildContext context, double opacity, Widget? child) {
                  return Container(
                    margin: const EdgeInsets.all(50),
                    child: Opacity(
                        opacity: opacity,
                        child: Image.asset(
                          "assets/images/logo.png",
                        )),
                  );
                }),
          )
        ],
      ),
    );
  }
}
