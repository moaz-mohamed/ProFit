import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profit/services/firestore_database.dart';
import 'package:profit/services/validate.dart';
import 'package:profit/themes/theme_ui.dart';

import '../navigation_screen.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  DatabaseService dbService = DatabaseService();
  final formGlobalKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  String? userId;
  String userName = "";
  String userWeight = "";
  String userAge = "";
  String userHeight = "";

  getInitialData() async {
    await dbService.getFields();
    updateState();
  }

  @override
  void initState() {
    userId = auth.currentUser!.uid;
    getInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My info"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              card("Name", userName, Icons.person_rounded, _nameController),
              card("Age", userAge, Icons.calendar_today, _ageController),
              card("Weight", userWeight + " kg", Icons.fitness_center_sharp,
                  _weightController),
              card("Height", userHeight + " cm", Icons.height_outlined,
                  _heightController),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  dbService.updateInfo(
                      userAge, userHeight, userWeight, userName);

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TabBarPage()),
                      ModalRoute.withName('/success'));
                },
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Flexible(
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  minimumSize: const Size.fromHeight(50),
                ),
              ),
            ],
          ),
        ));
  }

  openDialogueBox(BuildContext context, String attribute,
      TextEditingController controller) {
    return showDialog(
        context: context,
        builder: (context) {
          if (attribute == 'Name') {
            return AlertDialog(
              title: Text('Edit ' + attribute),
              content: SingleChildScrollView(
                child: Form(
                  key: formGlobalKey,
                  child: Column(
                    children: [
                      TextFormField(
                          controller: controller,
                          decoration: InputDecoration(hintText: attribute),
                          validator: (value) {
                            if (!Validators.validateName(value!.trim())) {
                              return "Enter Correct Name";
                            } else {
                              return null;
                            }
                          }),
                    ],
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    final formKey = formGlobalKey.currentState;
                    if (formKey!.validate()) {
                      formKey.save();
                      updateTextField();
                      Navigator.pop(context);
                      controller.clear();
                    }
                  },
                  child: const Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                )
              ],
            );
          } else {
            return AlertDialog(
              title: Text('Edit ' + attribute),
              content: SingleChildScrollView(
                child: Form(
                  key: formGlobalKey,
                  child: Column(children: [
                    numberField(controller, attribute),
                  ]),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    final formKey = formGlobalKey.currentState;
                    if (formKey!.validate()) {
                      formKey.save();
                      updateTextField();
                      Navigator.pop(context);
                      controller.clear();
                    }
                  },
                  child: const Text('Edit'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                )
              ],
            );
          }
        });
  }

  card(String attribute, String attributeValue, IconData iconData,
      TextEditingController controller) {
    return Card(
      elevation: 7,
      child: ListTile(
        title: Text(attribute,
            style: const TextStyle(color: Colors.black, fontSize: 18.0)),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text(attributeValue,
              style:
                  const TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
        ),
        leading: Icon(
          iconData,
          color: Colors.grey,
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: EdgeInsets.zero,
            primary: FitnessAppTheme.nearlyBlue,
            onPrimary: Colors.black,
          ),
          onPressed: () {
            openDialogueBox(context, attribute, controller);
          },
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  numberField(TextEditingController controler, String fieldName) {
    return TextFormField(
        controller: controler,
        decoration: InputDecoration(hintText: fieldName),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[1-9][0-9]*")),
          FilteringTextInputFormatter.digitsOnly
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return fieldName + ' is required';
          }
        });
  }

  updateState() {
    setState(() {
      userName = dbService.updatedName!;
      userAge = dbService.updatedage!;
      userWeight = dbService.updatedWeight!;
      userHeight = dbService.updatedheight!;
    });
  }

  updateTextField() {
    setState(() {
      if (_nameController.text.isNotEmpty) {
        userName = _nameController.text;
      }
      if (_heightController.text.isNotEmpty) {
        userHeight = _heightController.text;
      }
      if (_weightController.text.isNotEmpty) {
        userWeight = _weightController.text;
      }
      if (_ageController.text.isNotEmpty) {
        userAge = _ageController.text;
      }
    });
  }

  //resetAlldata() {}
}
