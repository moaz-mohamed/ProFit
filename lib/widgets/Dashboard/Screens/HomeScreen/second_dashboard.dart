import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:profit/themes/ThemeUI.dart';
import 'package:flutter/material.dart';
import 'package:profit/services/firestore_database.dart';
import 'custom_meal_text.dart';

class SecondDashboard extends StatelessWidget {
  List<String> meals = [
    "Eggs 4 kCal",
    "Pasta 100 kCal",
  ];

  SecondDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        body: ListView(
          children: [
            Container(
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
                          'assets/meals/icon1.png',
                          fit: BoxFit.fill,
                          width: 30,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Breakfast",
                            style: FitnessAppTheme.selectorBigTextAction),
                      ]),
                      //CustomMealText(text: meals[0]),
                      ElevatedButton(
                        onPressed: () {
                          DatabaseService().AddBreakfastToFirestoreUser(
                              id: FirebaseAuth.instance.currentUser!.uid,
                              name: "breakfast23",
                              calories: 2.1,
                              quantity: 3.2,
                              protein: 777.7,
                              fat: 5.5,
                              carbs: 6.2);
                        },
                        child: Icon(Icons.add, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.zero,
                          primary: FitnessAppTheme.nearlyBlue,
                          onPrimary: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  StreamBuilder(
                      stream: DatabaseService().getUserDocStream(
                          id: FirebaseAuth.instance.currentUser!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data as DocumentSnapshot;
                          var breakfast = data['breakfast'];
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: breakfast.length,
                            itemBuilder: (context, curr) {
                              return CustomMealText(
                                text: breakfast[curr]['name']
                                        .toString()
                                        .toUpperCase() +
                                    " " +
                                    breakfast[curr]['calories'].toString() +
                                    " " +
                                    breakfast[curr]['quantity'].toString() +
                                    "KCal",
                              );
                            },
                          );
                        } else {
                          return Text("No data");
                        }
                      }),
                ],
              ),
            ),
            Container(
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
                          'assets/meals/icon2.png',
                          fit: BoxFit.fill,
                          width: 30,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Lunch",
                            style: FitnessAppTheme.selectorBigTextAction),
                      ]),
                      ElevatedButton(
                        onPressed: () {
                          DatabaseService().AddLunchToFirestoreUser(
                              id: FirebaseAuth.instance.currentUser!.uid,
                              name: "lunch23",
                              calories: 2.1,
                              quantity: 3.2,
                              protein: 777.7,
                              fat: 5.5,
                              carbs: 6.2);
                        },
                        child: Icon(Icons.add, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.zero,
                          primary: FitnessAppTheme.nearlyBlue,
                          onPrimary: Colors.black,
                        ),
                      )
                    ],
                  ),
                  StreamBuilder(
                      stream: DatabaseService().getUserDocStream(
                          id: FirebaseAuth.instance.currentUser!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data as DocumentSnapshot;
                          var lunch = data['lunch'];
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: lunch.length,
                            itemBuilder: (context, curr) {
                              return CustomMealText(
                                text: lunch[curr]['name']
                                        .toString()
                                        .toUpperCase() +
                                    " " +
                                    lunch[curr]['calories'].toString() +
                                    " " +
                                    lunch[curr]['quantity'].toString() +
                                    "KCal",
                              );
                            },
                          );
                        } else {
                          return Text("No data");
                        }
                      }),
                ],
              ),
            ),
            Container(
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
                            'assets/meals/icon3.png',
                            fit: BoxFit.fill,
                            width: 30,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Dinner",
                              style: FitnessAppTheme.selectorBigTextAction),
                        ]),
                        ElevatedButton(
                          onPressed: () {
                            DatabaseService().AddDinnerToFirestoreUser(
                                id: FirebaseAuth.instance.currentUser!.uid,
                                name: "dinner23",
                                calories: 2.1,
                                quantity: 3.2,
                                protein: 777.7,
                                fat: 5.5,
                                carbs: 6.2);
                          },
                          child: Icon(Icons.add, color: Colors.white),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            primary: FitnessAppTheme.nearlyBlue,
                            onPrimary: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    StreamBuilder(
                        stream: DatabaseService().getUserDocStream(
                            id: FirebaseAuth.instance.currentUser!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data as DocumentSnapshot;
                            var dinner = data['dinner'];
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: dinner.length,
                              itemBuilder: (context, curr) {
                                return CustomMealText(
                                  text: dinner[curr]['name']
                                          .toString()
                                          .toUpperCase() +
                                      " " +
                                      dinner[curr]['calories'].toString() +
                                      " " +
                                      dinner[curr]['quantity'].toString() +
                                      "KCal",
                                );
                              },
                            );
                          } else {
                            return Text("No data");
                          }
                        }),
                  ]),
            ),
            Container(
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
                          'assets/meals/icon4.png',
                          fit: BoxFit.fill,
                          width: 30,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Workout",
                            style: FitnessAppTheme.selectorBigTextAction),
                      ]),
                      ElevatedButton(
                        onPressed: () {
                          DatabaseService().AddWorkoutToFirestoreUser(
                            id: FirebaseAuth.instance.currentUser!.uid,
                            name: "workout23",
                            duration: 22,
                            burnedCalories: 200,
                          );
                        },
                        child: Icon(Icons.add, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.zero,
                          primary: FitnessAppTheme.nearlyBlue,
                          onPrimary: Colors.black,
                        ),
                      )
                    ],
                  ),

                  // streambuilder workout
                  StreamBuilder(
                      stream: DatabaseService().getUserDocStream(
                          id: FirebaseAuth.instance.currentUser!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data as DocumentSnapshot;
                          var workout = data['workout'];
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: workout.length,
                            itemBuilder: (context, curr) {
                              return CustomMealText(
                                text: workout[curr]['name']
                                        .toString()
                                        .toUpperCase() +
                                    " " +
                                    workout[curr]['calories'].toString() +
                                    " " +
                                    workout[curr]['quantity'].toString() +
                                    "KCal",
                              );
                            },
                          );
                        } else {
                          return Text("No data");
                        }
                      }),
                ],
              ),
            ),
          ],
        ));
  }
}
