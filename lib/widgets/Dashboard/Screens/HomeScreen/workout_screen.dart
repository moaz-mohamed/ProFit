import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profit/services/firestore_database.dart';
import 'package:profit/themes/ThemeUI.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/workout_cubit/workout_cubit.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  String? _chosenValue;

  String? _text;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Container(
            padding: EdgeInsets.all(30),
            width: MediaQuery.of(context).size.width / 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: FitnessAppTheme.white,
              boxShadow: [
                BoxShadow(
                  color: FitnessAppTheme.nearlyBlack.withOpacity(0.12),
                  blurRadius: 5.0,
                  spreadRadius: 1.1,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton<String>(
                  isExpanded: true,
                  value: _chosenValue,
                  //elevation: 5,
                  style: FitnessAppTheme.selectorMiniLabel,
                  elevation: 2,

                  items: <String>[
                    'Walking',
                    'Bicycling',
                    'Jogging',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  hint: const Text(
                    "Choose your Workout",
                    style: FitnessAppTheme.selectorMiniLabel,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _chosenValue = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  // regex with text input formatter for number input
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[1-9][0-9]*")),
                    FilteringTextInputFormatter.digitsOnly
                  ],

                  onTap: () {},
                  onChanged: (value) {
                    setState(() {
                      _text = value;
                    });
                  },

                  decoration: const InputDecoration(
                    labelText: "Duration(min)",
                    hintText: "Enter your duration",
                  ),
                ),

                // submit button
                const SizedBox(
                  height: 40,
                ),
                BlocListener<WorkoutCubit, WorkoutState>(
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              FitnessAppTheme.nearlyBlue),
                          foregroundColor:
                              MaterialStateProperty.all(FitnessAppTheme.white)),
                      child: const Text(
                        'Continue',
                      ),
                      // on pressed
                      onPressed: () {
                        if (_text != null &&
                            _text != "" &&
                            _chosenValue != null) {
                          context
                              .read<WorkoutCubit>()
                              .addWorkout(_chosenValue!, _text!);
                        } else {
                          // show dialog
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Error"),
                              content: const Text("Please fill all the fields"),
                              actions: [
                                TextButton(
                                  child: const Text("Ok"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                          );
                        }
                      }),
                  listener: (context, state) {
                    if (state is WorkoutCalculationState) {
                      // add workout to firestore

                      DatabaseService().AddWorkoutToFirestoreUser(
                        id: FirebaseAuth.instance.currentUser!.uid,
                        name: state.workout.toString(),
                        burnedCalories: double.parse(
                            (double.parse(state.workoutCalculation)
                                .toStringAsFixed(2))),
                        duration: double.parse(_text!),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
