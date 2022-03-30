
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import 'MainTabScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
              child: Container(
                  margin: const EdgeInsets.only(left: 30.0, right: 40.0),
                  child: Lottie.asset('assets/animations/splash_anim.json'))),
          Align(
            alignment: Alignment.center,
            child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                curve: Curves.ease,
                onEnd: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainTabScreen()));
                },
                duration: const Duration(seconds: 3),
                builder: (BuildContext context, double opacity, Widget? child) {
                  return Container(
                    margin: const EdgeInsets.all(50),
                    child: Opacity(opacity: opacity, child: Container()),
                  );
                }),
          )
        ],
      ),
    );
  }
}
