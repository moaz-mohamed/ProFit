import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:profit/services/firestore_database.dart';
import 'package:profit/themes/ThemeUI.dart';

class FatsIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return StreamBuilder(
            stream: DatabaseService().getUserDocStream(id: FirebaseAuth.instance.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data as DocumentSnapshot;
                var remainingFats = double.parse((data['remainingFats']).toString()).toInt();
                var recoFats = (((double.parse((data['calories']).toString()).toDouble()) * (30 / 100)) / 9).toInt();
                double fatsPercent = (recoFats - remainingFats) / recoFats;
                fatsPercent <= 1 ? fatsPercent = fatsPercent : fatsPercent = 1;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Image.asset(
                          "assets/home_screen/Fats.png",
                          scale: 2.6,
                        ),
                        Text(
                          " Fats",
                          style: FitnessAppTheme.carbsIndicator,
                        ),
                      ],
                    ),
                    LinearPercentIndicator(
                      percent: fatsPercent,
                      width: constraints.maxWidth,
                      lineHeight: constraints.maxHeight * 0.1,
                      backgroundColor: Colors.black26,
                      animation: true,
                      animationDuration: 2000,
                      linearGradient: LinearGradient(colors: <Color>[
                        Colors.yellow.withOpacity(0.1),
                        Colors.yellow.withOpacity(0.2),
                        Colors.yellow.withOpacity(0.3),
                        Colors.yellow.withOpacity(0.4),
                        Colors.yellow.withOpacity(0.5),
                        Colors.yellow.withOpacity(0.6),
                        Colors.yellow.withOpacity(0.7),
                        Colors.yellow.withOpacity(0.8),
                        Colors.yellow.withOpacity(0.9),
                        Colors.yellow.withOpacity(1),
                      ]),
                      clipLinearGradient: true,
                      linearStrokeCap: LinearStrokeCap.roundAll,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          remainingFats.toString(),
                          style: FitnessAppTheme.carbsIndicatorValue,
                        ),
                        Text(
                          " grams left",
                          style: FitnessAppTheme.carbsIndicatorUnit,
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const Text(
                  "",
                  style: FitnessAppTheme.carbsIndicatorValue,
                );
              }
            });
      },
    );
  }
}
