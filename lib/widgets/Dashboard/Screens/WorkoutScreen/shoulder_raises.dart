import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:profit/themes/theme_ui.dart';
import 'package:profit/services/workout_services.dart';

class ShoulderRaises extends StatefulWidget {
  @override
  State<ShoulderRaises> createState() => _ShoulderRaisesState();
}

class _ShoulderRaisesState extends State<ShoulderRaises> {
  late String _responseMessage;
  late String _caloriesBurnt;
  WorkoutServices workoutServices = WorkoutServices();

  @override
  void initState() {
    super.initState();
    _responseMessage = "Zero";
    _caloriesBurnt = "Zero";
  }

  calculateReps() async {
    final _pickedFile = await workoutServices.getFile();
    setState(() {
      _responseMessage = "...";
      _caloriesBurnt = "...";
    });
    final _pickedFileCompressed = await workoutServices.compressFile(_pickedFile);
    final _response = await workoutServices.uploadFile(_pickedFileCompressed, "shoulders");
    setState(() {
      _responseMessage = _response;
      _caloriesBurnt = (double.parse(_responseMessage) * 0.2).toStringAsFixed(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ProFit"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Image.asset(
                  'assets/workout_screen/shoulder_icon.png',
                  scale: 3,
                ),
                Text(
                  " Sholder Raises ",
                  style: FitnessAppTheme.workoutTitle,
                ),
                Image.asset(
                  'assets/workout_screen/shoulder_icon_flipped.png',
                  scale: 3,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/workout_screen/counter.png',
                  scale: 1,
                ),
                Text(
                  " Reps Count",
                  style: FitnessAppTheme.repsCountTitle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  _responseMessage,
                  style: FitnessAppTheme.repsCountValue,
                ),
                Text(
                  " Reps",
                  style: FitnessAppTheme.repsCountUnit,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/workout_screen/fire.png',
                  scale: 1,
                ),
                Text(
                  " You have burnt",
                  style: FitnessAppTheme.repsCountTitle,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  _caloriesBurnt,
                  style: FitnessAppTheme.repsCountValue,
                ),
                Text(
                  " KCal",
                  style: FitnessAppTheme.repsCountUnit,
                ),
              ],
            ),
            ElevatedButton(
              child: Text(
                "Upload my workout",
                style: FitnessAppTheme.upload,
              ),
              onPressed: calculateReps,
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(Size(
                  MediaQuery.of(context).size.width - 80,
                  MediaQuery.of(context).size.height * 0.08,
                )),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                side: MaterialStateProperty.all(const BorderSide(color: Colors.blue, width: 2)),
                overlayColor: MaterialStateProperty.all(Colors.blue),
              ),
            ),
            Image.asset(
              'assets/workout_screen/shoulder_press.gif',
              scale: 4,
            ),
          ],
        ),
      ),
    );
  }
}
