import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:profit/services/firestore_database.dart';
import 'package:profit/themes/ThemeUI.dart';

class ProteinIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return StreamBuilder(
            stream: DatabaseService().getUserDocStream(id: FirebaseAuth.instance.currentUser!.uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data as DocumentSnapshot;
                var remainingProtein = double.parse((data['remainingProteins']).toString()).toInt();
                var recoProtein = (((double.parse((data['calories']).toString()).toDouble()) * (30 / 100)) / 4).toInt();
                double proteinPercent = (recoProtein - remainingProtein) / recoProtein;
                proteinPercent <= 1 ? proteinPercent = proteinPercent : proteinPercent = 1;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Image.asset(
                          "assets/home_screen/Meat.png",
                          scale: 2.6,
                        ),
                        Text(
                          " Protein",
                          style: FitnessAppTheme.carbsIndicator,
                        ),
                      ],
                    ),
                    LinearPercentIndicator(
                      percent: proteinPercent,
                      width: constraints.maxWidth,
                      lineHeight: constraints.maxHeight * 0.1,
                      backgroundColor: Colors.black26,
                      animation: true,
                      animationDuration: 2000,
                      linearGradient: LinearGradient(colors: <Color>[
                        Colors.red.withOpacity(0.1),
                        Colors.red.withOpacity(0.2),
                        Colors.red.withOpacity(0.3),
                        Colors.red.withOpacity(0.4),
                        Colors.red.withOpacity(0.5),
                        Colors.red.withOpacity(0.6),
                        Colors.red.withOpacity(0.7),
                        Colors.red.withOpacity(0.8),
                        Colors.red.withOpacity(0.9),
                        Colors.red.withOpacity(1),
                      ]),
                      clipLinearGradient: true,
                      linearStrokeCap: LinearStrokeCap.roundAll,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          remainingProtein.toString(),
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
