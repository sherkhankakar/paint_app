import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paint_app/screens/buyer_homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_bar_screen.dart';
import 'get_started_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loggedIn = false;
  String? userType;
  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('email') != null &&
        prefs.getString('email')!.isNotEmpty) {
      setState(() {
        loggedIn = true;
        userType = prefs.getString('userType');
      });
    } else {
      setState(() {
        loggedIn = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin().then((value) {
      loggedIn == true
          ? Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => userType == 'buyer'
                    ? const BuyerHomeScreen()
                    : const BottomBarScreen(),
              ),
            )
          : Timer(const Duration(seconds: 2), () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const GetStartedScreen()));
            });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(0, 240, 255, 1),
              Color.fromRGBO(158, 0, 255, 0.82),
              Color.fromRGBO(82, 0, 255, 0.77)
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: 150,
                width: 140,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/cons.png",
                    height: 45,
                    width: 160,
                  ),
                  Image.asset(
                    "assets/images/est.png",
                    height: 25,
                    width: 120,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
