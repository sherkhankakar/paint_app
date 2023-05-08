import 'package:flutter/material.dart';
import 'package:paint_app/screens/login_screen.dart';

class SellerCategory extends StatefulWidget {
  const SellerCategory({Key? key}) : super(key: key);

  @override
  State<SellerCategory> createState() => _SellerCategoryState();
}

class _SellerCategoryState extends State<SellerCategory> {
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
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
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
                    Image.asset(
                      "assets/images/est.png",
                      height: 25,
                      width: 120,
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
                                  builder: (context) => const LoginScreen(
                                        userType: 'painter',
                                      )));
                        },
                        child: Container(
                          height: 140,
                          //width: 250,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage('assets/images/painter.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // child: Center(
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(20),
                          //     child: Image.asset(
                          //       'assets/images/painter.jpg',height: 200,
                          //
                          //     ),
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 35,
                        width: 130,
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
                            'Painter',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
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
                    Transform.translate(
                      offset: const Offset(0, 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen(
                                        userType: 'plumber',
                                      )));
                        },
                        child: Container(
                          height: 140,
                          //width: 250,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage('assets/images/plumber.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // child: Center(
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(20),
                          //     child: Image.asset(
                          //       'assets/images/painter.jpg',height: 200,
                          //
                          //     ),
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 35,
                        width: 130,
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
                            'Plumber',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
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
                    Transform.translate(
                      offset: const Offset(0, 15),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen(
                                        userType: 'tile installer',
                                      )));
                        },
                        child: Container(
                          height: 140,
                          //width: 250,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage('assets/images/tile.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // child: Center(
                          //   child: ClipRRect(
                          //     borderRadius: BorderRadius.circular(20),
                          //     child: Image.asset(
                          //       'assets/images/painter.jpg',height: 200,
                          //
                          //     ),
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 35,
                        width: 130,
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
                            'Tile Installer',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Sansita'),
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
      ),
    );
  }
}
