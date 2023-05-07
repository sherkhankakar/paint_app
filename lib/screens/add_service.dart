import 'package:flutter/material.dart';
import 'package:paint_app/screens/bottom_bar_screen.dart';

import '../models/service_model.dart';
import '../services/firebase_services.dart';

class AddServiceScreen extends StatefulWidget {
  const AddServiceScreen({Key? key}) : super(key: key);

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final ServiceModel _serviceModel = ServiceModel();

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameCtr = TextEditingController();
  TextEditingController locationCtr = TextEditingController();
  TextEditingController descriptionCtr = TextEditingController();
  TextEditingController paintQtyCtr = TextEditingController();
  TextEditingController paintCostCtr = TextEditingController();
  TextEditingController lobourQtyCtr = TextEditingController();
  TextEditingController labourCostCtr = TextEditingController();
  TextEditingController wallQtyCtr = TextEditingController();
  TextEditingController wallCostCtr = TextEditingController();
  TextEditingController doorQtyCtr = TextEditingController();
  TextEditingController doorCostCtr = TextEditingController();
  TextEditingController windowQtyCtr = TextEditingController();
  TextEditingController windowCostCtr = TextEditingController();
  TextEditingController brushQtyCtr = TextEditingController();
  TextEditingController brushCostCtr = TextEditingController();
  TextEditingController tapeQtyCtr = TextEditingController();
  TextEditingController tapeCostCtr = TextEditingController();
  TextEditingController wallCleanerQty = TextEditingController();
  TextEditingController wallCleanerCost = TextEditingController();

  void _submitForm() async {
    if (nameCtr.text.isNotEmpty ||
        lobourQtyCtr.text.isNotEmpty ||
        locationCtr.text.isNotEmpty ||
        doorCostCtr.text.isNotEmpty ||
        descriptionCtr.text.isNotEmpty ||
        windowCostCtr.text.isNotEmpty ||
        windowQtyCtr.text.isNotEmpty ||
        paintCostCtr.text.isNotEmpty ||
        paintQtyCtr.text.isNotEmpty ||
        wallCleanerCost.text.isNotEmpty ||
        wallCleanerQty.text.isNotEmpty ||
        wallCostCtr.text.isNotEmpty) {
      await AuthService().addService({
        'name': nameCtr.text,
        'location': locationCtr.text,
        'description': descriptionCtr.text,
        'paintQty': paintQtyCtr.text,
        'paintCost': paintCostCtr.text,
        'labourQty': lobourQtyCtr.text,
        'labourCost': labourCostCtr.text,
        'wallQty': wallQtyCtr.text,
        'wallCost': wallCostCtr.text,
        'doorQty': doorQtyCtr.text,
        'doorCost': doorCostCtr.text,
        'windowQty': windowQtyCtr.text,
        'windowCost': windowCostCtr.text,
        'brushQty': brushQtyCtr.text,
        'brushCost': brushCostCtr.text,
        'tapeQty': tapeQtyCtr.text,
        'tapeCost': tapeCostCtr.text,
        'wallCleanerQty': wallCleanerQty.text,
        'wallCleanerCost': wallCleanerCost.text,
      }).whenComplete(
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (ctx) => const BottomBarScreen()),
            (route) => false),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please provide the above details correctly')));
    }

    // Process the form data
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
          'Add Service',
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: kToolbarHeight + 25),
                Row(
                  children: [
                    const Text('Name: '),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(child: customTextField(nameCtr, 'Name', 'name')),
                  ],
                ),
                const SizedBox(height: 12),
                //location
                Row(
                  children: [
                    const Text('Location: '),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: customTextField(
                            locationCtr, 'Location', 'location')),
                  ],
                ),
                const SizedBox(height: 12),
                //description
                Row(
                  children: [
                    const Text('Description: '),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: customTextField(
                            descriptionCtr, 'Description', 'description')),
                  ],
                ),
                const SizedBox(height: 12),
                //paint cost
                Row(
                  children: [
                    const Text('Paint: '),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: customTextField(
                            paintQtyCtr, 'Quantity', 'quantity')),
                    const SizedBox(width: 8),
                    Expanded(
                        child: customTextField(
                            paintCostCtr, 'Enter cost', 'paint\'s cost'))
                  ],
                ),
                const SizedBox(height: 12),
                //wall area
                Row(
                  children: [
                    const Text('Wall Area: '),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: customTextField(
                            wallQtyCtr, 'Wall Area in sqft', 'wall area')),
                    const SizedBox(width: 8),
                    Expanded(
                        child: customTextField(
                            wallCostCtr, 'Enter cost', 'wall area\'s cost'))
                  ],
                ),
                const SizedBox(height: 12),
                //door area
                Row(
                  children: [
                    const Text('Door area: '),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: customTextField(
                            doorQtyCtr, 'Number of doors', 'number of doors')),
                    const SizedBox(width: 8),
                    Expanded(
                        child: customTextField(
                            doorCostCtr, 'Enter cost', 'doors\'s cost'))
                  ],
                ),
                const SizedBox(height: 12),
                //windows area
                Row(
                  children: [
                    const Text('Window area: '),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: customTextField(windowQtyCtr,
                            'Windows area in sqft', 'windows area')),
                    const SizedBox(width: 8),
                    Expanded(
                        child: customTextField(windowCostCtr,
                            'Enter windows cost', 'windows\'s cost'))
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Labours: '),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: customTextField(lobourQtyCtr,
                            'Number of Labours', 'number of labour')),
                    const SizedBox(width: 8),
                    Expanded(
                        child: customTextField(
                            labourCostCtr, 'Enter cost', 'labours\'s cost'))
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Painter\'s tape: '),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: customTextField(
                            tapeQtyCtr, 'Quantity', 'quantity')),
                    const SizedBox(width: 8),
                    Expanded(
                        child: customTextField(tapeCostCtr, 'Enter cost',
                            'painter\'s tape\'s cost'))
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Brushes: '),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: customTextField(
                            brushQtyCtr, 'Quantity', 'quantity')),
                    const SizedBox(width: 8),
                    Expanded(
                        child: customTextField(
                            brushCostCtr, 'Enter cost', 'brushes\'s cost'))
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Wall Cleaner: '),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: customTextField(
                            wallCleanerQty,
                            'Number of wall cleaners',
                            'number of wall cleaners')),
                    const SizedBox(width: 8),
                    Expanded(
                        child: customTextField(wallCleanerCost, 'Enter cost',
                            'wall cleaner\'s cost'))
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitForm();
                    }
                  },
                  child: const Text('Add Service'),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextField(
      TextEditingController ctr, String hintText, String errorMsg) {
    return TextFormField(
      controller: ctr,
      decoration: InputDecoration(labelText: hintText),
      validator: (value) {
        if (value == null && value!.isEmpty) {
          return 'Please enter a $errorMsg';
        }
        return null;
      },
    );
  }
}
