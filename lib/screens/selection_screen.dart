import 'package:flutter/material.dart';
import 'package:paint_app/screens/seller_category.dart';

import 'login_screen.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/cons.png",
                    height: 45,
                    width: 160,
                  ),
                  Transform.translate(
                    offset: const Offset(2,-2),
                    child: const Text('Estimation',style: TextStyle(
                        shadows: <Shadow>[
                          Shadow(
                              offset: Offset(0, 2.0),
                              blurRadius: 5.0,
                              color: Colors.black54),
                        ],
                        color: Color.fromRGBO(204, 204, 204, 1), fontSize: 23, fontFamily: 'Sansita',fontWeight: FontWeight.w600),),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Stack(
                children: [
                  Transform.translate(
                    offset: const Offset(0, 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SellerCategory()));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/seller.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromRGBO(143, 0, 255, 1),
                              Color.fromRGBO(13, 179, 182, 1)
                            ],
                          )),
                      child: const Center(
                        child: Text(
                          'Seller',
                          style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(
                                    offset: Offset(0, 2.0),
                                    blurRadius: 5.0,
                                    color: Colors.black54),
                              ],
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Sansita'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(
                            userType: 'buyer',
                          ),
                        ),
                      );
                    },
                    child: Transform.translate(
                      offset: const Offset(0, 15),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/buyer.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromRGBO(143, 0, 255, 1),
                              Color.fromRGBO(13, 179, 182, 1)
                            ],
                          )),
                      child: const Center(
                        child: Text(
                          'Buyer',
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
                              ]

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
