import 'package:flutter/material.dart';

class HirePainter extends StatefulWidget {
  const HirePainter({Key? key}) : super(key: key);

  @override
  State<HirePainter> createState() => _HirePainterState();
}

class _HirePainterState extends State<HirePainter> {
  bool sellerDetails = false;
  int currentIndex = 0;

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
          'Hire Painter',
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
        child: ListView.builder(
          itemCount: 5, // Number of items in the list
          itemBuilder: (BuildContext context, int index) {
            // Return a widget for each item in the list
            return Column(
              children: [
                const SizedBox(height: 15),
                containerTiles(index),
              ],
            );
          },
        ),
      ),
    );
  }

  containerTiles(int index) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: const Color.fromRGBO(40, 124, 210, 0.6)),
        child: Center(
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = index;
                    sellerDetails = true;
                  });
                },
                child: currentIndex == index
                    ? !sellerDetails
                        ? Row(
                            children: [
                              const CircleAvatar(
                                radius: 50,
                                backgroundColor:
                                    Color.fromRGBO(133, 131, 131, 1),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  SizedBox(height: 10),
                                  Text(
                                    'Name',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Sansita'),
                                  ),
                                  Text(
                                    'Amet minim mollit non deserunt\n'
                                    'ullamco est sit aliqua dolor do amet\n'
                                    'sint. Velit officia consequat duis enim\n'
                                    'velit mollit. Exercitation veniam\n'
                                    'consequat sunt nostrud amet.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Sansita'),
                                  ),
                                ],
                              )
                            ],
                          )
                        : Row(
                            children: [
                              const CircleAvatar(
                                radius: 50,
                                backgroundColor:
                                    Color.fromRGBO(133, 131, 131, 1),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 120,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Name',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Sansita'),
                                    ),
                                    const Text(
                                      'Amet minim mollit non deserunt sint.',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'Sansita'),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                          size: 20,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                          size: 20,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                          size: 20,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                          size: 20,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.orangeAccent,
                                          size: 20,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Charges',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Sansita'),
                                  ),
                                  const Text(
                                    '50 Rs per sq.ft',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontFamily: 'Sansita'),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 25,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          backgroundColor: const Color.fromRGBO(
                                              174, 203, 246, 1)),
                                      onPressed: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             const HirePainter()));
                                      },
                                      child: const Text(
                                        'Hire',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontFamily: 'Sansita',
                                            shadows: <Shadow>[
                                              Shadow(
                                                  offset: Offset(0, 2.0),
                                                  blurRadius: 5.0,
                                                  color: Colors.black54),
                                            ]),
                                      ),
                                      // fontSized: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                    : Row(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundColor: Color.fromRGBO(133, 131, 131, 1),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(height: 10),
                              Text(
                                'Name',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Sansita'),
                              ),
                              Text(
                                'Amet minim mollit non deserunt\n'
                                'ullamco est sit aliqua dolor do amet\n'
                                'sint. Velit officia consequat duis enim\n'
                                'velit mollit. Exercitation veniam\n'
                                'consequat sunt nostrud amet.',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontFamily: 'Sansita'),
                              ),
                            ],
                          )
                        ],
                      ))));
  }
}
