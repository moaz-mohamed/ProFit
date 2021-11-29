//import 'package:calory_calc/common/theme/theme.dart';
//import 'package:calory_calc/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profit/design/ThemeUI.dart';

class PhysicalParametersForm extends StatefulWidget {
  const PhysicalParametersForm({
    Key? key,
    required this.onCompleted,
    required this.weightController,
    required this.heightController,
    required this.ageController,
  }) : super(key: key);

  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController ageController;

  final Function(String weight, String height, String age, bool gender)
      onCompleted;

  @override
  _PhysicalParametersFormState createState() => _PhysicalParametersFormState();
}

class _PhysicalParametersFormState extends State<PhysicalParametersForm> {
  bool _gender = true;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final weight = widget.weightController.text;
    final height = widget.heightController.text;
    final age = widget.ageController.text;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text("ProFit"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: const [
                Text(
                  'Physical Parameters',
                  style: FitnessAppTheme.headlineBlue,
                ),
                Text(
                  'Enter your physical information',
                  style: FitnessAppTheme.subtitle,
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                      onTap: () {},
                      controller: widget.weightController,
                      cursorColor: theme.primaryColor,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[1-9][0-9]*")),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        labelText: "Weight",
                        hintText: "Enter your weight in kilograms",
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Weight is required';
                        }
                      }),
                  const SizedBox(height: 5),
                  TextFormField(
                    onTap: () {},
                    controller: widget.heightController,
                    cursorColor: theme.primaryColor,
                    keyboardType: TextInputType.number,
                    //style: TextStyle(color: Colors.blueGrey),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[1-9][0-9]*")),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        labelText: "Height",
                        hintText: "Enter your height in centimeters",
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Weight is required';
                      }
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    onTap: () {},
                    controller: widget.ageController,
                    cursorColor: theme.primaryColor,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[1-9][0-9]*")),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      labelText: "Age",
                      hintText: "Enter your age",
                      hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Age is required';
                      }
                    },
                  ),
                  const SizedBox(height: 5),
                  _buildGenderPicker(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SizedBox(
                width: 200,
                child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            FitnessAppTheme.nearlyBlue),
                        foregroundColor:
                            MaterialStateProperty.all(FitnessAppTheme.white)),
                    child: const Text(
                      'Continue',
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        {
                          widget.onCompleted(weight, height, age, _gender);
                          Navigator.pushNamed(context, '/activity');
                        }
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildGenderPicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            Radio(
              value: true,
              groupValue: _gender,
              activeColor: FitnessAppTheme.nearlyBlue,
              onChanged: (bool? value) {
                setState(
                  () {
                    _gender = value!;
                  },
                );
              },
            ),
            const Text("Male"),
          ],
        ),
        Row(
          children: [
            Radio(
              value: false,
              groupValue: _gender,
              activeColor: FitnessAppTheme.nearlyBlue,
              onChanged: (bool? value) {
                setState(
                  () {
                    _gender = value!;
                  },
                );
              },
            ),
            const Text("Female"),
          ],
        ),
      ],
    );
  }

  // void _onButtonPressed() {
  //   final weight = widget.weightController.text;
  //   final height = widget.heightController.text;
  //   final age = widget.ageController.text;

  //   if (_formKey.currentState!.validate()) {
  //     {
  //       widget.onCompleted(weight, height, age, _gender);
  //     }
  //   }
  // }
}
