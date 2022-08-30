import 'dart:async';
import 'package:flutter/material.dart';
import 'package:login_portfolio/view/home.view.dart';
import 'package:login_portfolio/view/login_form.view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogin();
  }

  //check if user is login or not

  void isLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLogin = sharedPreferences.getBool("isLogin") ?? false;

    //check

    if (isLogin) {
      Timer(
        const Duration(seconds: 8),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeView()),
            (route) => false),
      );
    } else {
      Timer(
        const Duration(seconds: 8),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
            (route) => false),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              "Splash Screen",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
