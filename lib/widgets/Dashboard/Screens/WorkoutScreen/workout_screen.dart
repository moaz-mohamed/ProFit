import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:profit/themes/theme_ui.dart';
import 'package:profit/widgets/Dashboard/Screens/WorkoutScreen/biceps_curl.dart';
import 'package:profit/widgets/Dashboard/Screens/WorkoutScreen/shoulder_raises.dart';
import 'package:profit/widgets/Dashboard/Screens/WorkoutScreen/squats.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            // color: Colors.red,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "SPOT ME",
                  style: FitnessAppTheme.spotMe1,
                ),
                Image.asset(
                  'assets/workout_screen/bodybuilding.jpg',
                  scale: 3,
                ),
                Text(
                  "Gym Personal Trainer",
                  style: FitnessAppTheme.spotMe2,
                ),
              ],
            ),
          ),
          Text(
            "Pick up your workout",
            style: FitnessAppTheme.pick,
          ),
          Container(
            // color: Colors.red,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.45,
            margin: EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Bicep Curl",
                            style: FitnessAppTheme.workoutLabel,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Primary Muscles: ",
                                style: FitnessAppTheme.workoutData1,
                              ),
                              Image.asset(
                                'assets/workout_screen/bicep_icon.png',
                                scale: 6,
                              ),
                              Text(
                                " Biceps",
                                style: FitnessAppTheme.workoutData2,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Secondary Muscles: ",
                                style: FitnessAppTheme.workoutData1,
                              ),
                              Image.asset(
                                'assets/workout_screen/forearms_icon.png',
                                scale: 6,
                              ),
                              Text(
                                " Forearms",
                                style: FitnessAppTheme.workoutData2,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/workout_screen/bicep.gif',
                        scale: MediaQuery.of(context).size.height * 0.01,
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(
                      MediaQuery.of(context).size.width - 40,
                      MediaQuery.of(context).size.height * 0.12,
                    )),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.all(const BorderSide(color: Colors.blue, width: 2)),
                    // overlayColor: MaterialStateProperty.all(Colors.black12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BicepCurls(),
                      ),
                    );
                  },
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Shoulder Raises",
                            style: FitnessAppTheme.workoutLabel,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Primary Muscles: ",
                                style: FitnessAppTheme.workoutData1,
                              ),
                              Image.asset(
                                'assets/workout_screen/shoulder_icon.png',
                                scale: 6,
                              ),
                              Text(
                                " Shoulders",
                                style: FitnessAppTheme.workoutData2,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Secondary Muscles: ",
                                style: FitnessAppTheme.workoutData1,
                              ),
                              Image.asset(
                                'assets/workout_screen/traps_icon.png',
                                scale: 6,
                              ),
                              Text(
                                " Traps",
                                style: FitnessAppTheme.workoutData2,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/workout_screen/shoulder_press.gif',
                        scale: MediaQuery.of(context).size.height * 0.01,
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(
                      MediaQuery.of(context).size.width - 40,
                      MediaQuery.of(context).size.height * 0.12,
                    )),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.all(const BorderSide(color: Colors.blue, width: 2)),
                    // overlayColor: MaterialStateProperty.all(Colors.black12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShoulderRaises(),
                      ),
                    );
                  },
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            "Leg Squats",
                            style: FitnessAppTheme.workoutLabel,
                          ),
                          Row(
                            children: <Widget>[
                              const Text(
                                "Primary: ",
                                style: FitnessAppTheme.workoutData1,
                              ),
                              Image.asset(
                                'assets/workout_screen/quads_icon.png',
                                scale: 6,
                              ),
                              const Text(
                                " Quads  ",
                                style: FitnessAppTheme.workoutData2,
                              ),
                              Image.asset(
                                'assets/workout_screen/glutes_icon.png',
                                scale: 6,
                              ),
                              const Text(
                                " Glutes",
                                style: FitnessAppTheme.workoutData2,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              const Text(
                                "Secondary Muscles: ",
                                style: FitnessAppTheme.workoutData1,
                              ),
                              Image.asset(
                                'assets/workout_screen/abs_icon.png',
                                scale: 6,
                              ),
                              const Text(
                                " Abs",
                                style: FitnessAppTheme.workoutData2,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/workout_screen/squats.gif',
                        scale: MediaQuery.of(context).size.height * 0.01,
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(
                      MediaQuery.of(context).size.width - 40,
                      MediaQuery.of(context).size.height * 0.12,
                    )),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    side: MaterialStateProperty.all(const BorderSide(color: Colors.blue, width: 2)),
                    // overlayColor: MaterialStateProperty.all(Colors.black12),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Squats(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
