import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool userDetails = false;
  bool isEstimatesShowing = false;
  bool showCalculatedEstimate = false;
  int currentIndex = 0;
  int viewIndex = 0;
  int backCount = 0;

  void _toggleDetails(bool isEstimate) {
    setState(() {
      isEstimatesShowing = !isEstimatesShowing;
      backCount = 1;

      // viewIndex = index;
      // userDetails = true;
      print('View Clicked $backCount ');
    });
  }

  void toggleEstimatedCosts() {
    setState(() {
      showCalculatedEstimate = !showCalculatedEstimate;
      debugPrint(showCalculatedEstimate.toString());
      backCount = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(110, 132, 255, 0.54),
        automaticallyImplyLeading: false,
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
                containerTile(index),
              ],
            );
          },
        ),
      ),
    );
  }

  containerTile(int index) {
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
            userDetails = true;
          });
        },
        child: currentIndex == index
            ? !userDetails
                ? Row(
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
                  )
                : Column(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 25,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 80),
                        child: Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ),
                      rowTiles('Name', 'ABC'),
                      rowTiles('Location', 'ABC'),
                      clickableTiles('Estimates', 'View', index),
                      clickableTiles('Total Estimates', 'Calculate', index),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          FaIcon(FontAwesomeIcons.whatsapp),
                          FaIcon(
                            FontAwesomeIcons.phone,
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      InkWell(
                        onTap: () {
                          setState(() {
                            userDetails = false;
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 110,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromRGBO(26, 41, 128, 1),
                                  Color.fromRGBO(38, 208, 206, 1),
                                ],
                              )),
                          child: const Center(
                            child: Text(
                              'Back',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Sansita'),
                            ),
                          ),
                        ),
                      )
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
              ),
      )),
    );
  }

  clickableTiles(String title, String clickable, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Sansita'),
          ),
          InkWell(
            onTap: () {
              _toggleDetails(false);
              // setState(() {
              //   isEstimatesShowing = !isEstimatesShowing;
              //   // viewIndex = index;
              //   // userDetails = true;
              //   print('View Clicked ');
              // });
            },
            child: Text(
              clickable,
              style: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Sansita'),
            ),
          ),
          if (isEstimatesShowing)
            Column(
              children: const [
                CircleAvatar(),
                Text(
                  'Name',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sansita'),
                ),
                CircleAvatar()
              ],
            )
        ],
      ),
    );
  }

  rowTiles(String name, String result, {String? cost}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Sansita'),
          ),
          Text(
            result,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Sansita'),
          ),
          Text(
            cost ?? '',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Sansita'),
          ),
        ],
      ),
    );
  }
}
