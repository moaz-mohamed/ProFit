import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:profit/services/firestore_database.dart';
import 'package:profit/themes/ThemeUI.dart';
import 'package:number_slide_animation/number_slide_animation.dart';

class CaloriesIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CircularPercentIndicator(
          radius: constraints.maxHeight * 0.9,
          percent: 0.8,
          backgroundWidth: 6,
          lineWidth: 16,
          animation: true,
          animationDuration: 2000,
          backgroundColor: Colors.black26,
          linearGradient: LinearGradient(colors: <Color>[
            Colors.red.withOpacity(0.1),
            Colors.red.withOpacity(0.2),
            Colors.red.withOpacity(0.3),
            Colors.red.withOpacity(0.4),
            Colors.red.withOpacity(0.5),
            Colors.blue.withOpacity(0.6),
            Colors.blue.withOpacity(0.7),
            Colors.blue.withOpacity(0.8),
            Colors.blue.withOpacity(0.9),
            Colors.blue.withOpacity(1),
          ]),
          rotateLinearGradient: true,
          circularStrokeCap: CircularStrokeCap.round,
          widgetIndicator: Image.asset(
            "assets/home_screen/Plate.png",
            scale: 2.6,
          ),
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                  stream: DatabaseService().getUserDocStream(
                      id: FirebaseAuth.instance.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data as DocumentSnapshot;
                      var totalCalories =
                          double.parse(data['remainingCalories'].toString())
                              .toInt()
                              .toString();
                      return Text(
                        totalCalories,
                        style: FitnessAppTheme.eatenIndicatorValue,
                      );
                    } else {
                      return const Text(
                        "",
                        style: FitnessAppTheme.eatenIndicatorValue,
                      );
                    }
                  }),
              Text(
                " kCal left",
                style: FitnessAppTheme.caloriesIndicatorUnit,
              ),
            ],
          ),
        );
      },
    );
  }
}
