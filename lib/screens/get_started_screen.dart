import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';

import 'selection_screen.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                Transform.translate(
                  offset: const Offset(2, -2),
                  child: const Text(
                    'Estimation',
                    style: TextStyle(
                        shadows: <Shadow>[
                          Shadow(
                              offset: Offset(0, 2.0),
                              blurRadius: 5.0,
                              color: Colors.black54),
                        ],
                        color: Color.fromRGBO(204, 204, 204, 1),
                        fontSize: 23,
                        fontFamily: 'Sansita',
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Welcome:\nThis app is for estimation. A user who'
                ' hire a person to complete their home painting, plumbing, marble installing and electricians task.'
                ' Its easy to use for sellers as well as for buyers',
                style: TextStyle(
                    color: Colors.white, fontSize: 18, fontFamily: 'Sansita'),
              ),
            ),
            const SizedBox(height: 90),
            Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0, 5),
                    spreadRadius: 1,
                    blurRadius: 4,
                  )
                ],
                borderRadius: BorderRadius.circular(30),
              ),
              child: ActionSlider.standard(
                backgroundColor: const Color.fromRGBO(158, 0, 255, 0.82),
                toggleColor: const Color.fromRGBO(60, 16, 83, 1),
                width: MediaQuery.of(context).size.width / 1.5,
                height: 50,
                icon: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromRGBO(255, 17, 231, 1),
                          Color.fromRGBO(158, 44, 249, 1),
                          Color.fromRGBO(121, 16, 255, 1)
                        ],
                      )),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
                actionThresholdType: ThresholdType.release,
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(0, 2.0),
                            blurRadius: 5.0,
                            color: Colors.black54),
                      ],
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sansita'),
                ),
                action: (controller) async {
                  controller.loading(); //starts loading animation
                  await Future.delayed(const Duration(seconds: 1));
                  controller.success();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectionScreen()));
                  await Future.delayed(const Duration(seconds: 1));
                  controller.reset(); //resets the slider
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
