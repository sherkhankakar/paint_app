import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'hire_painter.dart';

class PlumbingEstimation extends StatefulWidget {
  const PlumbingEstimation({Key? key}) : super(key: key);

  @override
  State<PlumbingEstimation> createState() => _PlumbingEstimationState();
}

class _PlumbingEstimationState extends State<PlumbingEstimation> {
  final TextEditingController _pipeLengthCtr = TextEditingController();
  final TextEditingController _pipeWidthCtr = TextEditingController();
  final TextEditingController _tapeCtr = TextEditingController();
  final TextEditingController _showerCtr = TextEditingController();
  final TextEditingController _commodeCtr = TextEditingController();
  final TextEditingController _washBasinCtr = TextEditingController();
  final TextEditingController _numberOfWashrooms = TextEditingController();

  final List<String> pipeLength = [
    'inch',
    'half inch',
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
    for (var i = 0; i < (pipeLength.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(4);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        itemsHeights.add(4);
      }
    }
    return itemsHeights;
  }

  final _key = GlobalKey<FormState>();

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
          'Plumbing Estimation',
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
        child: Container(
          width: double.maxFinite,
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
              key: _key,
              child: Column(
                children: [
                  const SizedBox(height: 120),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Pipes',
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
                  const SizedBox(height: 15),
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
                          controller: _pipeLengthCtr,
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
                              'inch',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Sansita',
                              ),
                            ),
                            items: _addDividersAfterItems(pipeLength),
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
                          controller: _pipeWidthCtr,
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
                              'inch',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Sansita',
                              ),
                            ),
                            items: _addDividersAfterItems(pipeLength),
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
                  const SizedBox(height: 25),
                  rowTiles('Washrooms', _numberOfWashrooms, 'Number of washrooms'),
                  const SizedBox(height: 15),

                  rowTiles('Taps', _tapeCtr, 'No of Taps'),
                  const SizedBox(height: 15),
                  rowTiles('Shower', _showerCtr, 'No of Shower'),
                  const SizedBox(height: 15),
                  rowTiles('Commode', _commodeCtr, 'No of Commode'),
                  const SizedBox(height: 15),
                  rowTiles('Wash Basin', _washBasinCtr, 'No of Wash Basin'),
                  const SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton(
                      onPressed: () {
                        if(_key.currentState!.validate()){
                          showAlertDialog();
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

  rowTile(String title, String result) {
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


  rowTiles(String title, TextEditingController Ctr, String hintValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
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
            controller: Ctr,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Sansita',
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintValue,
                hintStyle: const TextStyle(
                  color: Colors.white70,
                  fontFamily: 'Sansita',
                )),
          ),
        )
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
                    serviceType: 'plumber',
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




        paintCost = ((int.parse(_pipeLengthCtr.text) * int.parse(_pipeWidthCtr.text) * 120)+ (int.parse(_commodeCtr.text) * 950) + (int.parse(_showerCtr.text)*900) + (int.parse(_tapeCtr.text)*300)+(int.parse(_washBasinCtr.text)* 1200)).toDouble();


        data = {


          'paint_type': '${int.parse(_pipeLengthCtr.text) * int.parse(_pipeWidthCtr.text)}',
          'coat': _tapeCtr.text,
          'wall_area':_showerCtr.text,
          'door_area':_commodeCtr.text,
          'window_area': _washBasinCtr.text,
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
                    rowTile('Total Pipe Area', '${int.parse(_pipeLengthCtr.text) * int.parse(_pipeWidthCtr.text)}'),
                    const SizedBox(height: 10),
                    rowTile('No.of Tapes', _tapeCtr.text),
                    const SizedBox(height: 10),
                    rowTile('No.of. Showers', _showerCtr.text),
                    const SizedBox(height: 10),
                    rowTile('No.of Commodes',
                        _commodeCtr.text),
                    const SizedBox(height: 10),
                    rowTile('No.of Washrooms', _numberOfWashrooms.text),
                    const SizedBox(height: 10),
                    rowTile('Cost per washroom',
                        '${paintCost!.toStringAsFixed(2)}PKR'),
                    const SizedBox(height: 10),
                    rowTile('Grand Total',
                        '${(paintCost! * int.parse(_numberOfWashrooms.text)).toStringAsFixed(2)}PKR'),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              actions: [Center(child: okButton)],
            )));
      },
    );
  }


}
