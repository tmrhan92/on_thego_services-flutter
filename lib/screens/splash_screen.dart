import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    loadView();
  }

  void loadView() async {
    await Future.delayed(const Duration(seconds: 10));
    goStart();
  }

  void goStart() {
    Navigator.pushNamed(context, '/signinscreen'); // تأكد من وجود هذه الشاشة
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash2.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
