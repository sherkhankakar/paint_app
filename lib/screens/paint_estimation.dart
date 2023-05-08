import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:paint_app/screens/hire_painter.dart';

class MyDataObject {
  final int id;

  MyDataObject({required this.id});
}

class PaintEstimation extends StatefulWidget {
  const PaintEstimation({Key? key}) : super(key: key);

  @override
  State<PaintEstimation> createState() => _PaintEstimationState();
}

class _PaintEstimationState extends State<PaintEstimation> {
  final TextEditingController _coatNumberCtr = TextEditingController();
  final List<TextEditingController> _wallWidthCtr = [];
  final List<TextEditingController> _wallHeightCtr = [];
  final List<TextEditingController> _doorHeightCtr = [];
  final List<TextEditingController> _doorWidthCtr = [];
  final List<TextEditingController> _windowsHeightCtr = [];
  final List<TextEditingController> _windowsWidthCtr = [];

  final List<MyDataObject> _wallList = [];
  final List<MyDataObject> _doorList = [];
  final List<MyDataObject> _windowList = [];

  final List<String> paintTypes = [
    'Type 1',
    'Type 2',
    'Type 3',
    'Type 4',
  ];
  String? selectedValue;

  List<DropdownMenuItem<String>> _addDividersAfterItems(
      List<String> paintTypes) {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var type in paintTypes) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: type,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                type,
                style: const TextStyle(
                    color: Colors.white, fontSize: 14, fontFamily: 'Sansita'),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (type != paintTypes.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

  List<double> _getCustomItemsHeights() {
    List<double> itemsHeights = [];
    for (var i = 0; i < (paintTypes.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(40);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        itemsHeights.add(4);
      }
    }
    return itemsHeights;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    for (var controller in _doorHeightCtr) {
      controller.dispose();
    }
    for (var controller in _doorWidthCtr) {
      controller.dispose();
    }
    for (var controller in _wallHeightCtr) {
      controller.dispose();
    }
    for (var controller in _wallWidthCtr) {
      controller.dispose();
    }
    for (var controller in _windowsHeightCtr) {
      controller.dispose();
    }
    for (var controller in _windowsWidthCtr) {
      controller.dispose();
    }
    super.dispose();
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
        title: const Text(
          'Paint Estimation',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Paint Type',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Sansita',
                            shadows: <Shadow>[
                              Shadow(
                                  offset: Offset(0, 2.0),
                                  blurRadius: 5.0,
                                  color: Colors.black54),
                            ]),
                      ),
                      Container(
                        // height: 35,
                        width: 200,
                        decoration: const BoxDecoration(color: Colors.white12),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            iconStyleData: const IconStyleData(
                              iconEnabledColor: Colors.white,
                              icon: Icon(Icons.keyboard_arrow_down_rounded),
                              openMenuIcon:
                                  Icon(Icons.keyboard_arrow_up_rounded),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'Select Paint type',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Sansita',
                              ),
                            ),
                            items: _addDividersAfterItems(paintTypes),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value as String;
                              });
                            },
                            buttonStyleData:
                                const ButtonStyleData(height: 40, width: 140),
                            dropdownStyleData: const DropdownStyleData(
                              decoration: BoxDecoration(color: Colors.black54),
                              maxHeight: 200,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              // customHeights: _getCustomItemsHeights(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Coat',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Sansita',
                            shadows: <Shadow>[
                              Shadow(
                                  offset: Offset(0, 2.0),
                                  blurRadius: 5.0,
                                  color: Colors.black54),
                            ]),
                      ),
                      Container(
                        height: 35,
                        width: 200,
                        decoration: const BoxDecoration(color: Colors.white12),
                        child: TextField(
                          controller: _coatNumberCtr,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Sansita',
                          ),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Times',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Sansita',
                              )),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Walls',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
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
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    //color: Colors.grey,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _wallList.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == _wallList.length) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 20),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white12),
                                child: IconButton(
                                  onPressed: () {
                                    final ctr = TextEditingController();
                                    final ctr2 = TextEditingController();
                                    setState(() {
                                      _wallList.add(
                                          MyDataObject(id: _wallList.length));
                                      _wallHeightCtr.add(ctr);
                                      _wallWidthCtr.add(ctr2);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white12),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _wallList.removeLast();
                                      _wallHeightCtr.removeLast();
                                      _wallWidthCtr.removeLast();
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return containerSize('New Width', 'New Height',
                              _wallWidthCtr[index], _wallHeightCtr[index]);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Doors',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
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
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    //color: Colors.grey,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _doorList.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == _doorList.length) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 20),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white12),
                                child: IconButton(
                                  onPressed: () {
                                    final ctr = TextEditingController();
                                    final ctr2 = TextEditingController();
                                    setState(() {
                                      _doorList.add(
                                          MyDataObject(id: _doorList.length));
                                      _doorHeightCtr.add(ctr);
                                      _doorWidthCtr.add(ctr2);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white12),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _doorList.removeLast();
                                      _doorHeightCtr.removeLast();
                                      _doorWidthCtr.removeLast();
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return containerSize('New Width', 'New Height',
                              _doorWidthCtr[index], _doorHeightCtr[index]);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Windows',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
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
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    //color: Colors.grey,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _windowList.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == _windowList.length) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 20),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white12),
                                child: IconButton(
                                  onPressed: () {
                                    final ctr = TextEditingController();
                                    final ctr2 = TextEditingController();
                                    setState(() {
                                      _windowList.add(
                                          MyDataObject(id: _windowList.length));
                                      _windowsHeightCtr.add(ctr);
                                      _windowsWidthCtr.add(ctr2);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white12),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _windowList.removeLast();
                                      _windowsHeightCtr.removeLast();
                                      _windowsWidthCtr.removeLast();
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return containerSize(
                              'New Width',
                              'New Height',
                              _windowsWidthCtr[index],
                              _windowsHeightCtr[index]);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_wallList.isNotEmpty &&
                              _doorList.isNotEmpty &&
                              _windowList.isNotEmpty &&
                              _coatNumberCtr.text.isNotEmpty) {
                            showAlertDialog();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Please provide walls, doors, windows, and coat details'),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(110, 132, 255, 0.54),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Sansita',
                            shadows: <Shadow>[
                              Shadow(
                                  offset: Offset(0, 2.0),
                                  blurRadius: 5.0,
                                  color: Colors.black54),
                            ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  containerSize(String width, String height, TextEditingController heightCtr,
      TextEditingController widthCtr) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white12),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Text(
                width,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Sansita',
                    shadows: <Shadow>[
                      Shadow(
                          offset: Offset(0, 2.0),
                          blurRadius: 5.0,
                          color: Colors.black54),
                    ]),
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Provide this value';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                  controller: heightCtr,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Sansita',
                  ),
                ),
              ),
              // const SizedBox(height: 20),
              const Expanded(
                child: Text(
                  'Feet',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Sansita',
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(0, 2.0),
                            blurRadius: 5.0,
                            color: Colors.black54),
                      ]),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 30),
        Container(
          height: 100,
          width: 100,
          margin: const EdgeInsets.only(right: 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white12),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Text(
                height,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Sansita',
                    shadows: <Shadow>[
                      Shadow(
                          offset: Offset(0, 2.0),
                          blurRadius: 5.0,
                          color: Colors.black54),
                    ]),
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Provide this';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                  controller: widthCtr,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Sansita',
                  ),
                ),
              ),
              // const SizedBox(height: 20),
              const Expanded(
                child: Text(
                  'Feet',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Sansita',
                      shadows: <Shadow>[
                        Shadow(
                            offset: Offset(0, 2.0),
                            blurRadius: 5.0,
                            color: Colors.black54),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  showAlertDialog() {
    // set up the button
    double? paintCost;
    Map<String, dynamic>? data;
    Widget okButton = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 120,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: const Color.fromRGBO(186, 186, 186, 1)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Close',
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
        SizedBox(
          width: 120,
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: const Color.fromRGBO(186, 186, 186, 1)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HirePainter(
                    paintCost: paintCost!,
                    serviceType: 'painter',
                    data: data,
                  ),
                ),
              );
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
    );

    // set up the AlertDialog
    // AlertDialog alert = stderr// show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        double? wallArea;
        for (int i = 0; i < _wallHeightCtr.length; i++) {
          wallArea = double.parse(_wallHeightCtr[i].text) *
              double.parse(_wallWidthCtr[i].text) *
              _wallList.length;
        }

        double? doorArea;
        for (int i = 0; i < _doorHeightCtr.length; i++) {
          doorArea = double.parse(_doorHeightCtr[i].text) *
              double.parse(_doorWidthCtr[i].text) *
              _doorList.length;
        }
        double? windowArea;
        for (int i = 0; i < _windowsWidthCtr.length; i++) {
          windowArea = double.parse(_windowsHeightCtr[i].text) *
              double.parse(_windowsWidthCtr[i].text) *
              _windowList.length;
        }
        totalArea = wallArea! - doorArea! - windowArea!;
        final totalPaint = totalArea! / 350;
        log(_coatNumberCtr.text);

        paintCost = totalPaint * 3000 * double.parse(_coatNumberCtr.text);
        data = {
          'paint_type': selectedValue,
          'coat': _coatNumberCtr.text,
          'wall_area': totalArea.toString(),
          'door_area': doorArea.toString(),
          'window_area': windowArea.toString(),
          'paint_cost': paintCost,
        };
        return StatefulBuilder(
            builder: ((context, setState) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: const Color.fromRGBO(99, 98, 98, 1),
                  content: SizedBox(
                    height: 230,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        rowTiles('Paint Type', selectedValue!),
                        const SizedBox(height: 10),
                        rowTiles('Coat', _coatNumberCtr.text),
                        const SizedBox(height: 10),
                        rowTiles('Total Area', '$totalArea sqft'),
                        const SizedBox(height: 10),
                        rowTiles('Total Paint',
                            '${totalPaint.toStringAsFixed(2)} gillion'),
                        const SizedBox(height: 10),
                        rowTiles('Per Gillion Price', '3000 PKR'),
                        const SizedBox(height: 10),
                        rowTiles('Total Price of Paint',
                            '${paintCost!.toStringAsFixed(2)}PKR'),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  actions: [Center(child: okButton)],
                )));
      },
    );
  }

  rowTiles(String title, String result) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Sansita',
              shadows: <Shadow>[
                Shadow(
                    offset: Offset(0, 2.0),
                    blurRadius: 5.0,
                    color: Colors.black54),
              ]),
        ),
        Text(
          result,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Sansita',
              shadows: <Shadow>[
                Shadow(
                    offset: Offset(0, 2.0),
                    blurRadius: 5.0,
                    color: Colors.black54),
              ]),
        ),
      ],
    );
  }

  double? totalArea;
}
