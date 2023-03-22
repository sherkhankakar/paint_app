import 'package:flutter/material.dart';
import 'package:paint_app/screens/home_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey expansionTile = GlobalKey();

  final TextEditingController _emailController = TextEditingController();

  // Controller

  final linearGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromRGBO(23, 213, 255, 1),
      Color.fromRGBO(224, 26, 255, 0.9),
    ],
  );

  final buttonGradient =
      const LinearGradient(colors: [Color(0xff1A2980), Color(0xff26D0CE)]);

  @override
  void initState() {
    // initialize controller

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(gradient: linearGradient),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 55),
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
            ),
            const SizedBox(height: 50),
            Container(
              height: 531,
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 34),
              decoration: BoxDecoration(
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/bg.png')),
                borderRadius: BorderRadius.circular(35),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 50),

                  /// Sign in  &  Sign up Widget
                  //

                  /// Email Field Widget
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                      right: 40,
                      top: 10,
                    ),
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: 'Enter  Your  Email',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Sansita',
                          )),
                    ),
                  ),

                  /// Continue Button Widget
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                      right: 40,
                      top: 60,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      },
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(
                            gradient: buttonGradient,
                            color: Colors.blue,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        child: const Center(
                            child: Text(
                          'Send Code',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Sansita'),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
