import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:profit/services/firestore_database.dart';
import 'package:profit/themes/ThemeUI.dart';

class EatenIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/home_screen/Apple.png",
                    scale: 2.6,
                  ),
                  const Text(
                    " Eaten",
                    style: FitnessAppTheme.eatenIndicatorText,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StreamBuilder(
                      stream: DatabaseService().getUserDocStream(
                          id: FirebaseAuth.instance.currentUser!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data as DocumentSnapshot;
                          var eaten =
                              double.parse(data['eatenCalories'].toString())
                                  .toInt()
                                  .toString();
                          return Text(
                            eaten,
                            style: FitnessAppTheme.eatenIndicatorValue,
                          );
                        } else {
                          return const Text(
                            "0",
                            style: FitnessAppTheme.eatenIndicatorValue,
                          );
                        }
                      }),
                  const Text(
                    " (kCal)",
                    style: FitnessAppTheme.eatenIndicatorUnit,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
