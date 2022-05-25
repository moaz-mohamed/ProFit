import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:profit/services/firestore_database.dart';
import 'package:profit/themes/ThemeUI.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:profit/widgets/Dashboard/Screens/HomeScreen/workout_provider.dart';

import 'package:profit/widgets/FoodAPI/food_main.dart';
import 'package:profit/widgets/IntroPage/Intro/login_screen.dart';

class Dashboard extends StatelessWidget {
  List<String> dashboardHeaders = [
    "Breakfast",
    "Lunch",
    "Dinner",
    "Workout",
  ];

  Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Dashboard"),

      // ),
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (BuildContext, int index) {
            return Container(
              constraints: BoxConstraints(
                maxHeight: double.infinity,
              ),
              margin: EdgeInsets.all(30),
              padding: const EdgeInsets.all(10.0),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Image.asset(
                            'assets/home_screen/icon' +
                                (index + 1).toString() +
                                '.png',
                            fit: BoxFit.fill,
                            width: 30,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(dashboardHeaders[index],
                              style: FitnessAppTheme.selectorBigTextAction),
                        ]),

                        ElevatedButton(
                          onPressed: () {
                            if (dashboardHeaders[index] == "Breakfast") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FoodMain(
                                      foodtype: 1,
                                    ),
                                  ));
                            } else if (dashboardHeaders[index] == "Lunch") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FoodMain(
                                      foodtype: 2,
                                    ),
                                  ));
                            } else if (dashboardHeaders[index] == "Dinner") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FoodMain(
                                      foodtype: 3,
                                    ),
                                  ));
                            } else if (dashboardHeaders[index] == "Workout") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WorkoutProvider()));
                            }
                          },
                          child: Icon(Icons.add, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            primary: FitnessAppTheme.nearlyBlue,
                            onPrimary: Colors.black,
                          ),
                        ),
                        //CustomMealText(text: meals),
                      ],
                    ),
                    // map a list into a list of widgets
                    // make a stream builder for breakfast in firestore
                    StreamBuilder(
                        stream: DatabaseService().getUserDocStream(
                            id: FirebaseAuth.instance.currentUser!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data as DocumentSnapshot;
                            var dinner =
                                data[dashboardHeaders[index].toLowerCase()];
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: dinner.length,
                              itemBuilder: (context, curr) {
                                if (dashboardHeaders[index] == "Workout") {
                                  return Column(children: [
                                    Card(
                                      child: ListTile(
                                        title: Text(
                                            dinner[curr]['name'].toString()),
                                        subtitle: Text(dinner[curr]
                                                ['burnedCalories']
                                            .toString()),
                                        trailing: IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            DatabaseService()
                                                .deleteWorkoutFromFirestoreUser(
                                                    id: FirebaseAuth.instance
                                                        .currentUser!.uid,
                                                    index: curr,
                                                    calories: dinner[curr]
                                                        ['burnedCalories']);
                                          },
                                        ),
                                      ),
                                    ),
                                  ]);
                                } else {
                                  return Column(children: [
                                    Card(
                                      margin: EdgeInsets.all(3),
                                      elevation: 1,
                                      shape: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  FitnessAppTheme.nearlyWhite,
                                              width: 1)),
                                      child: ListTile(
                                        title: Text(
                                            dinner[curr]['name'].toString()),
                                        subtitle: Text(dinner[curr]['calories']
                                                .toString() +
                                            " kCal"),
                                        trailing: IconButton(
                                          icon: Icon(Icons.delete_outline),
                                          onPressed: () {
                                            DatabaseService()
                                                .deleteMealFromFirestoreUser(
                                                    id: FirebaseAuth.instance
                                                        .currentUser!.uid,
                                                    type:
                                                        dashboardHeaders[index],
                                                    index: curr);
                                          },
                                        ),
                                      ),
                                    )
                                  ]);
                                }
                              },
                            );
                          } else {
                            return Text("No Data");
                          }
                        }),
                  ]),
            );
          }),
    );
  }
}
