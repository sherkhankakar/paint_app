import 'package:flutter/material.dart';
import 'package:paint_app/screens/electrician_estimation.dart';
import 'package:paint_app/screens/get_started_screen.dart';
import 'package:paint_app/screens/marble_estimation.dart';
import 'package:paint_app/screens/paint_estimation.dart';
import 'package:paint_app/screens/plumbing_estimation.dart';
import 'package:paint_app/services/firebase_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_screen.dart';

class BuyerHomeScreen extends StatefulWidget {
  const BuyerHomeScreen({Key? key}) : super(key: key);

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(110, 132, 255, 0.54),
        leading: IconButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
            AuthService.signOut().whenComplete(() => Navigator.of(context)
                .pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (ctx) => const GetStartedScreen()),
                    (route) => false));
          },
          icon: const Icon(Icons.logout),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        centerTitle: true,
        toolbarHeight: 60,
        title: const Text(
          'Home Page',
          style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              fontFamily: 'Sansita',
              shadows: <Shadow>[
                Shadow(
                    offset: Offset(0, 2.0),
                    blurRadius: 5.0,
                    color: Colors.black54),
              ]),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const ProfileScreen()));
              },
              icon: const Icon(Icons.person_outline))
        ],
      ),
      body: Container(
        height: double.maxFinite,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(23, 213, 255, 1),
            Color.fromRGBO(224, 26, 255, 0.9),
          ],
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 120),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  gridContainers('Paint\nEstimates', 'assets/images/paint.jpeg',
                      page: const PaintEstimation()),
                  gridContainers(
                      'Marbles\nEstimates', 'assets/images/tile.jpeg',
                      page: const MarbleEstimation())
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  gridContainers(
                      'Plumbing\nEstimates', 'assets/images/plumber.jpeg',
                      page: const PlumbingEstimation()),
                  gridContainers('Electrician\nEstimates',
                      'assets/images/electrician.jpeg',
                      page: const ElectricianEstimation()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  gridContainers(String title, String img, {Widget? page}) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page!));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(56, 149, 235, 1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Sansita',
                  fontSize: 18,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                img,
                height: 90,
              ),
            )
          ],
        ),
      ),
    );
  }
}
