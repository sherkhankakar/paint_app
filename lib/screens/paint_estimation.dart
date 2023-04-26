import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class PaintEstimation extends StatefulWidget {
  const PaintEstimation({Key? key}) : super(key: key);

  @override
  State<PaintEstimation> createState() => _PaintEstimationState();
}

class _PaintEstimationState extends State<PaintEstimation> {
  final TextEditingController _coatNumberCtr = TextEditingController();
  final TextEditingController _wallWidthCtr = TextEditingController();
  final TextEditingController _wallHeightCtr = TextEditingController();
  final TextEditingController _doorHeightCtr = TextEditingController();
  final TextEditingController _doorWidthCtr = TextEditingController();
  final TextEditingController _windowsHeightCtr = TextEditingController();
  final TextEditingController _windowsWidthCtr = TextEditingController();
  final List<String> paintTypes = [
    'Type 1',
    'Type 1',
    'Type 1',
    'Type 1',
  ];
  String? selectedValue;

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Sansita',
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
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
                      height: 35,
                      width: 200,
                      decoration: const BoxDecoration(color: Colors.white12),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
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
                          color: Colors.black,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    containerSize(
                      'Total Width',
                      _wallWidthCtr,
                    ),
                    containerSize(
                      'Total Height',
                      _wallHeightCtr,
                    ),
                  ],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    containerSize(
                      'Total Width',
                      _doorWidthCtr,
                    ),
                    containerSize(
                      'Total Height',
                      _doorHeightCtr,
                    ),
                  ],
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    containerSize(
                      'Total Width',
                      _windowsWidthCtr,
                    ),
                    containerSize(
                      'Total Height',
                      _windowsHeightCtr,
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

  containerSize(String width, TextEditingController heightCtr) {
    return Container(
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
    );
  }
}
