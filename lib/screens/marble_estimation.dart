import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:paint_app/screens/hire_painter.dart';

class MyDataObject {
  final int id;

  MyDataObject({required this.id});
}

class MarbleEstimation extends StatefulWidget {
  const MarbleEstimation({Key? key}) : super(key: key);

  @override
  State<MarbleEstimation> createState() => _MarbleEstimationState();
}

class _MarbleEstimationState extends State<MarbleEstimation> {
  final TextEditingController _tileLengthCtr = TextEditingController();
  final TextEditingController _tileWidthCtr = TextEditingController();
  final TextEditingController _tileGapCtr = TextEditingController();
  final TextEditingController _wallWidthCtr = TextEditingController();
  final TextEditingController _wallHeightCtr = TextEditingController();
  final TextEditingController _doorHeightCtr = TextEditingController();
  final TextEditingController _doorWidthCtr = TextEditingController();
  final TextEditingController _windowsHeightCtr = TextEditingController();
  final TextEditingController _windowsWidthCtr = TextEditingController();

  final List<MyDataObject> _wallList = [];
  final List<MyDataObject> _doorList = [];
  final List<MyDataObject> _windowList = [];

  final List<String> tilesLength = [
    'cm',
    'ft',
    'inch',
    'm',
  ];
  String? selectedValue;

  List<DropdownMenuItem<String>> _addDividersAfterItems(
      List<String> tilesLength) {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var type in tilesLength) {
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
          if (type != tilesLength.last)
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
    for (var i = 0; i < (tilesLength.length * 2) - 1; i++) {
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
          'Tiles Estimation',
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 120),
                const Text(
                  'Tiles Size',
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 70,
                      child: Text(
                        'Length',
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
                    Container(
                      height: 35,
                      width: 130,
                      decoration: const BoxDecoration(color: Colors.white12),
                      child: TextField(
                        controller: _tileLengthCtr,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Sansita',
                        ),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '0.0',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Sansita',
                            )),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 70,
                      padding: const EdgeInsets.only(left: 1),
                      decoration: const BoxDecoration(color: Colors.white12),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          iconStyleData: const IconStyleData(
                            iconEnabledColor: Colors.white,
                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                            openMenuIcon: Icon(Icons.keyboard_arrow_up_rounded),
                          ),
                          isExpanded: true,
                          hint: const Text(
                            'cm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Sansita',
                            ),
                          ),
                          items: _addDividersAfterItems(tilesLength),
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
                          menuItemStyleData: MenuItemStyleData(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            customHeights: _getCustomItemsHeights(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 70,
                      child: Text(
                        'Width',
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
                    Container(
                      height: 35,
                      width: 130,
                      decoration: const BoxDecoration(color: Colors.white12),
                      child: TextField(
                        controller: _tileWidthCtr,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Sansita',
                        ),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '0.0',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Sansita',
                            )),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 70,
                      padding: const EdgeInsets.only(left: 1),
                      decoration: const BoxDecoration(color: Colors.white12),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          iconStyleData: const IconStyleData(
                            iconEnabledColor: Colors.white,
                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                            openMenuIcon: Icon(Icons.keyboard_arrow_up_rounded),
                          ),
                          isExpanded: true,
                          hint: const Text(
                            'cm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Sansita',
                            ),
                          ),
                          items: _addDividersAfterItems(tilesLength),
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
                          menuItemStyleData: MenuItemStyleData(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            customHeights: _getCustomItemsHeights(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 70,
                      child: Text(
                        'Tile Gap',
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
                    Container(
                      height: 35,
                      width: 130,
                      decoration: const BoxDecoration(color: Colors.white12),
                      child: TextField(
                        controller: _tileGapCtr,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Sansita',
                        ),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '0.0',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Sansita',
                            )),
                      ),
                    ),
                    Container(
                      height: 35,
                      width: 70,
                      padding: const EdgeInsets.only(left: 1),
                      decoration: const BoxDecoration(color: Colors.white12),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          iconStyleData: const IconStyleData(
                            iconEnabledColor: Colors.white,
                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                            openMenuIcon: Icon(Icons.keyboard_arrow_up_rounded),
                          ),
                          isExpanded: true,
                          hint: const Text(
                            'cm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Sansita',
                            ),
                          ),
                          items: _addDividersAfterItems(tilesLength),
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
                          menuItemStyleData: MenuItemStyleData(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            customHeights: _getCustomItemsHeights(),
                          ),
                        ),
                      ),
                    ),
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
                                  setState(() {
                                    _wallList.add(
                                        MyDataObject(id: _wallList.length));
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
                            _wallWidthCtr, _wallHeightCtr);
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
                                  setState(() {
                                    _doorList.add(
                                        MyDataObject(id: _doorList.length));
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
                            _doorWidthCtr, _doorHeightCtr);
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
                                  setState(() {
                                    _windowList.add(
                                        MyDataObject(id: _windowList.length));
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
                            _windowsWidthCtr, _windowsHeightCtr);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton(
                      onPressed: () {
                        showAlertDialog();
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
                  ),
                )
              ],
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
              TextField(
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
              // const SizedBox(height: 20),
              const Text(
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
              TextField(
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
              // const SizedBox(height: 20),
              const Text(
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
            ],
          ),
        ),
      ],
    );
  }

  showAlertDialog() {
    // set up the button
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
                      builder: (context) => const HirePainter(
                            paintCost: 2.0,
                            serviceType: 'tile installer',
                          )));
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
                        rowTiles('Tile Size', '12 cm'),
                        const SizedBox(height: 10),
                        rowTiles('Tile Gap', '0.25 cm'),
                        const SizedBox(height: 10),
                        rowTiles('Total Area', '250 sq/ft'),
                        const SizedBox(height: 10),
                        rowTiles('Total Tiles', '50 tiles'),
                        const SizedBox(height: 10),
                        rowTiles('Per Gillion Price', '100 rs'),
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
}
