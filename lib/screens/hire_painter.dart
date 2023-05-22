import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paint_app/services/firebase_services.dart';

class HirePainter extends StatefulWidget {
  const HirePainter(
      {Key? key,
      required this.paintCost,
      this.data,
      required this.serviceType,
      this.title = 'Painter'})
      : super(key: key);
  final double paintCost;
  final Map<String, dynamic>? data;
  final String serviceType;
  final String? title;

  @override
  State<HirePainter> createState() => _HirePainterState();
}

class _HirePainterState extends State<HirePainter> {
  bool sellerDetails = false;
  int currentIndex = 0;
  bool conditionMet = false;

  @override
  void initState() {
    print('data is here  =  ${widget.paintCost}');
    super.initState();
  }

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
        title: Text(
          'Hire ${widget.title}',
          style: const TextStyle(
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
          child: FutureBuilder<List<DocumentSnapshot<Object?>>>(
            future: AuthService.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                for (int i = 0; i < snapshot.data!.length; i++) {
                  // final pCost = snapshot.data![i].get('paintCost');
                  //double.parse(pCost) <= widget.paintCost &&
                  if (snapshot.data![i].get('service_type') ==
                      widget.serviceType) {
                    //  log('index : $i');
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        // final pCost = snapshot.data![index].get('paintCost');
                        if (snapshot.data![index].get('service_type') ==
                            widget.serviceType) {
                          return Column(
                            children: [
                              const SizedBox(height: 15),
                              containerTiles(index, snapshot.data![index]),
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
                  return Center(
                    child: Text(
                      '${widget.serviceType.toUpperCase()} is not found with your estimate',
                      style: const TextStyle(color: Colors.white),
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

  containerTiles(int index, DocumentSnapshot<Object?> data) {
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
                    sellerDetails = !sellerDetails;
                  });
                },
                child: currentIndex == index
                    ? !sellerDetails
                        ? SizedBox(
                            width: double.maxFinite,
                            height: 100,
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 50,
                                  backgroundColor:
                                      Color.fromRGBO(133, 131, 131, 1),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                        data.get('name'),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Sansita'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          data.get('description'),
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
                        : SizedBox(
                            width: double.maxFinite,
                            height: 100,
                            child: Row(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      Text(
                                        data.get('name'),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Sansita'),
                                      ),
                                      Expanded(
                                        child: Text(
                                          data.get('description'),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Sansita'),
                                        ),
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
                                //const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Estimation',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontFamily: 'Sansita'),
                                    ),
                                    Text(
                                      data.get('paintCost'),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Sansita'),
                                    ),
                                    const SizedBox(height: 20),
                                    ValueListenableBuilder(
                                      valueListenable: AuthService.msg,
                                      builder: (BuildContext context,
                                          dynamic value, Widget? child) {
                                        return SizedBox(
                                          height: 23,
                                          width: 65,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        174, 203, 246, 1)),
                                            onPressed: () {
                                              //hire button
                                              AuthService()
                                                  .sendRequest(widget.data!,
                                                      data.get('seller_id'))
                                                  .whenComplete(() {
                                                if (AuthService.msg.value ==
                                                    'Success') {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'Request sent to seller'),
                                                    ),
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        'error occured try again later',
                                                      ),
                                                    ),
                                                  );
                                                }
                                              });
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
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
                                  const SizedBox(height: 10),
                                  Text(
                                    data.get('name'),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Sansita'),
                                  ),
                                  Expanded(
                                    child: Text(
                                      data.get('description'),
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
                      ))));
  }
}
