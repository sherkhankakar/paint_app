import 'package:flutter/material.dart';

class ElectricianEstimation extends StatefulWidget {
  const ElectricianEstimation({Key? key}) : super(key: key);

  @override
  State<ElectricianEstimation> createState() => _ElectricianEstimationState();
}

class _ElectricianEstimationState extends State<ElectricianEstimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(110, 132, 255, 0.54),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_outlined),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40))),
        centerTitle: true,
        toolbarHeight: 60,
        title: const Text(
          'Electrician Estimation',
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
        child: const Center(
          child: Text(
            'Coming Soon',
            style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.w600,
                fontFamily: 'Sansita',
                shadows: <Shadow>[
                  Shadow(
                      offset: Offset(0, 2.0),
                      blurRadius: 5.0,
                      color: Colors.black54),
                ]),
          ),
        ),
      ),
    );
  }
}
