import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:profit/themes/ThemeUI.dart';
import 'dart:io';
import 'package:profit/services/workout_services.dart';

class BicepCurls extends StatefulWidget {
  @override
  State<BicepCurls> createState() => _BicepCurlsState();
}

class _BicepCurlsState extends State<BicepCurls> {
  late File _file;
  late String _responseMessage;
  late int repsCount;
  late double caloriesBurnt;
  WorkoutServices workoutServices = WorkoutServices();

  @override
  void initState() {
    super.initState();
    _responseMessage = "Zero";
  }

  // Future getFile() async {
  //   final pickedFile = await FilePicker.platform.pickFiles();
  //   setState(
  //     () {
  //       if (pickedFile != null) {
  //         _file = File(pickedFile.files.single.path!);
  //         uploadFile();
  //       } else {
  //         // User canceled the picker
  //       }
  //     },
  //   );
  // }
  //
  // uploadFile() async {
  //   final request = http.MultipartRequest('POST', Uri.parse('https://e209-41-237-128-245.eu.ngrok.io/upload'));
  //   final headers = {"Content-type": "multipart/form-data"};
  //   request.files.add(
  //     http.MultipartFile(
  //       'workoutVideo',
  //       _file!.readAsBytes().asStream(),
  //       _file!.lengthSync(),
  //       filename: _file!.path.split('/').last,
  //     ),
  //   );
  //   request.headers.addAll(headers);
  //   final response = await request.send();
  //   http.Response httpResponse = await http.Response.fromStream(response);
  //   final jsonResponse = jsonDecode(httpResponse.body);
  //   setState(() {
  //     responseMessage = jsonResponse['message'];
  //   });
  //   print(responseMessage);
  // }

  calculateReps() async {
    // final _pickedFile = await workoutServices.getFile();
    // final _response = await workoutServices.uploadFile(_pickedFile, "squats");
    // setState(() {
    //   _responseMessage = _response;
    // });
    // print(_response);
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
                  'assets/workout_screen/bicep_icon_flipped.png',
                  scale: 3,
                ),
                Text(
                  " BICEP CURLS ",
                  style: FitnessAppTheme.workoutTitle,
                ),
                Image.asset(
                  'assets/workout_screen/bicep_icon.png',
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
                  "12",
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
                  "120",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/workout_screen/step-1.png',
                          scale: 1.6,
                        ),
                        Container(
                          width: 180,
                          margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
                          child: Text(
                            "Stand with the feet hip distance apart.",
                            style: FitnessAppTheme.instructions,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/workout_screen/step-2.png',
                          scale: 1.6,
                        ),
                        Container(
                          width: 180,
                          margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
                          child: Text(
                            "Raise dumbbells up toward your shoulders.",
                            style: FitnessAppTheme.instructions,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/workout_screen/step-3.png',
                          scale: 1.6,
                        ),
                        Container(
                          width: 180,
                          margin: EdgeInsets.fromLTRB(6, 0, 0, 0),
                          child: Text(
                            "Lower dumbbells back to the start position.",
                            style: FitnessAppTheme.instructions,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Image.asset(
                  'assets/workout_screen/bicep.gif',
                  scale: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
