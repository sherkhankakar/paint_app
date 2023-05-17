import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paint_app/screens/get_started_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/estimated_costs.dart';
import '../services/firebase_services.dart';
import 'add_service.dart';

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

  bool conditionMet = false;
  void toggleEstimatedCosts() {
    setState(() {
      showCalculatedEstimate = !showCalculatedEstimate;
      debugPrint(showCalculatedEstimate.toString());
      backCount = 1;
    });
  }

  @override
  void initState() {
    super.initState();
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
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.signOut().whenComplete(
                () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => const GetStartedScreen()),
                  (route) => false,
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const AddServiceScreen(),
          ),
        ),
        child: const Icon(Icons.add),
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
          child: FutureBuilder<List<DocumentSnapshot<Object?>>>(
            future: AuthService().fetchRequests(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                for (int i = 0; i < snapshot.data!.length; i++) {
                  if (snapshot.data![i].get('seller_id') ==
                      FirebaseAuth.instance.currentUser!.uid) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.data![index].get('seller_id') ==
                            FirebaseAuth.instance.currentUser!.uid) {
                          return Column(
                            children: [
                              const SizedBox(height: 15),
                              containerTile(index, snapshot.data![index]),
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
                  }
                }
                // Condition not met for any item in snapshot.data
                if (!conditionMet) {
                  return const Center(
                    child: Text(
                      'You have 0 requests',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                return const SizedBox();
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
            },
          )),
    );
  }

  containerTile(int index, DocumentSnapshot service) {
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
            userDetails = !userDetails;
          });
        },
        child: currentIndex == index
            ? !userDetails
                ? SizedBox(
                    width: double.maxFinite,
                    height: 100,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Color.fromRGBO(133, 131, 131, 1),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                service.get('email') ?? 'name',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Sansita'),
                              ),
                              Expanded(
                                child: Text(
                                  'Estimated Budget ${service.get('paint_cost').toStringAsFixed(2)}',
                                  softWrap: true,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Sansita'),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
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
                      if (showCalculatedEstimate == true)
                        EstimatedCost(
                          service: service,
                        ),
                      // if (showCalculatedEstimate == false)
                      //   rowTiles('Name', service.get('name')),
                      // if (showCalculatedEstimate == false)
                      //   rowTiles('Location', service.get('location')),
                      // if (isEstimatesShowing == true)
                      //   rowTiles('Paint', service.get('paintQty') + ' gallon'),
                      // if (isEstimatesShowing == true)
                      //   rowTiles('Painter\'s tape', service.get('tapeQty')),
                      // if (isEstimatesShowing == true)
                      //   rowTiles('Wall Cleaner', service.get('wallCleanerQty')),
                      // if (isEstimatesShowing == true)
                      //   rowTiles('Brushes', service.get('brushQty')),
                      if (userDetails == true)
                        rowTiles(
                            'Wall Area', service.get('wall_area') + ' sqft'),
                      // if (isEstimatesShowing == true)
                      //   rowTiles('Door Area', service.get('doorQty') + ' sqft'),
                      // if (isEstimatesShowing == true)
                      //   rowTiles(
                      //       'Window Area', service.get('windowQty') + ' sqft'),
                      if (userDetails == true)
                        rowTiles(
                            'Door Area', service.get('door_area') + ' sqft'),
                      if (userDetails == true)
                        rowTiles('Window Area',
                            service.get('window_area') + ' sqft'),
                      if (userDetails == true)
                        rowTiles('Coat', service.get('coat') + ' x'),
                      if (userDetails == true)
                        rowTiles('Paint Type', service.get('paint_type')),
                      if (userDetails == true)
                        rowTiles(
                            'Paint Estimate',
                            service.get('paint_cost').toStringAsFixed(2) +
                                ' PKR'),
                      const SizedBox(height: 5),
                      if (isEstimatesShowing == false &&
                          showCalculatedEstimate == false)
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              log('message: $backCount');
                              setState(() {
                                if (backCount == 1) {
                                  isEstimatesShowing = false;
                                  showCalculatedEstimate = false;
                                  backCount = 0;
                                } else {
                                  userDetails = false;
                                }
                              });

                              //     .whenComplete(() {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        title: const Text('Buyer Contact Info'),
                                        content: const Text(
                                          'Contact buyer through WhatsApp',
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: [
                                          Center(
                                            child: IconButton(
                                              onPressed: () {
                                                openWhatsapp(
                                                    context: context,
                                                    text: 'hi',
                                                    number: '+923085991831');
                                              },
                                              icon: const FaIcon(
                                                FontAwesomeIcons.whatsapp,
                                                color: Colors.green,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ]);
                                  });
                              // });
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
                                  'Accept',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Sansita'),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              AuthService()
                                  .deleteRequest(service.id)
                                  .whenComplete(() {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Request deleted successfully'),
                                  ),
                                );
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
                                  'Reject',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Sansita'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
            : SizedBox(
                width: double.maxFinite,
                height: 100,
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Color.fromRGBO(133, 131, 131, 1),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.get('email'),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Sansita'),
                          ),
                          Expanded(
                            child: Text(
                              'Estimated Budget${service.get('paint_cost').toStringAsFixed(2)}',
                              softWrap: true,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Sansita'),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
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
              if (title == 'Estimates') {
                _toggleDetails(false);
              } else {
                toggleEstimatedCosts();
              }
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
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Sansita'),
            ),
          ),
          if (isEstimatesShowing)
            Column(
              children: const [
                Text(
                  'test',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sansita'),
                ),
              ],
            )
        ],
      ),
    );
  }

  rowTiles(
    String name,
    String result,
  ) {
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
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Sansita'),
          ),
          Text(
            result,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Sansita'),
          ),
        ],
      ),
    );
  }

  void openWhatsapp(
      {required BuildContext context,
      required String text,
      required String number}) async {
    var whatsappURlAndroid = "whatsapp://send?phone=+923085991831&text=$text";
    var whatsappURLIos =
        "https://wa.me/+923085991831?text=${Uri.tryParse(text)}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(
          whatsappURLIos,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    }
  }
}
