import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:profit/services/auth.dart';
import 'package:profit/services/firestore_database.dart';
import 'package:profit/themes/theme_ui.dart';

class MyFavourite extends StatefulWidget {
  @override
  _MyFavouriteState createState() => _MyFavouriteState();
}

class _MyFavouriteState extends State<MyFavourite> {
  DatabaseService dbService = DatabaseService();
  FirebaseAuth auth = FirebaseAuth.instance;
  String? userId;
  String? foodName;
  double? calories;
  double? quantity;
  double? protein;
  double? fat;
  double? carb;
  @override
  void initState() {
    userId = auth.currentUser!.uid;
    super.initState();
  }

  var myMenuItems = <String>[
    'Add to breakfast',
    'Add to lunch',
    'Add to dinner',
  ];
  onSelect(item) {
    switch (item) {
      case 'Add to breakfast':
        addToBreakfast();
        break;
      case 'Add to lunch':
        addToBreakLunch();
        break;
      case 'Add to dinner':
        addToDinner();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Favourites"),
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext, int index) {
            return Container(
              constraints: const BoxConstraints(
                maxHeight: double.infinity,
              ),
              margin: const EdgeInsets.all(30),
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
                    StreamBuilder(
                        stream: dbService.getUserDocStream(
                            id: FirebaseAuth.instance.currentUser!.uid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data as DocumentSnapshot;
                            var meal = data['favourites'];
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: meal.length,
                              itemBuilder: (context, curr) {
                                return Column(children: [
                                  Card(
                                    margin: EdgeInsets.all(3),
                                    elevation: 1,
                                    shape: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: FitnessAppTheme.nearlyWhite,
                                            width: 1)),
                                    child: ListTile(
                                      title: Row(
                                        children: [
                                          Text(meal[curr]['name'].toString()),
                                        ],
                                      ),
                                      subtitle: Text(
                                          meal[curr]['calories'].toString() +
                                              " kCal"),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          PopupMenuButton<String>(
                                              onSelected: onSelect,
                                              itemBuilder: (context) {
                                                return myMenuItems
                                                    .map((String choice) {
                                                  return PopupMenuItem<String>(
                                                    value: choice,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        updateState(
                                                            meal, index);
                                                        onSelect(choice);
                                                        Navigator.pop(
                                                            context, choice);
                                                      },
                                                      child: Text(choice),
                                                    ),
                                                  );
                                                }).toList();
                                              }),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              deleteFavourteItem(
                                                  meal, index, context);
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ]);
                              },
                            );
                          } else {
                            return const Text(" ");
                          }
                        }),
                  ]),
            );
          }),
    );
  }

  addToBreakfast() {
    dbService.addBreakfastToFirestoreUser(
      calories: calories!,
      carbs: carb!,
      fat: fat!,
      name: foodName!,
      id: userId!,
      protein: protein!,
      quantity: quantity!,
      date: DateTime.now(),
    );
  }

  addToBreakLunch() {
    dbService.addLunchToFirestoreUser(
      calories: calories!,
      carbs: carb!,
      fat: fat!,
      name: foodName!,
      id: userId!,
      protein: protein!,
      quantity: quantity!,
      date: DateTime.now(),
    );
  }

  addToDinner() {
    dbService.addDinnerToFirestoreUser(
      calories: calories!,
      carbs: carb!,
      fat: fat!,
      name: foodName!,
      id: userId!,
      protein: protein!,
      quantity: quantity!,
      date: DateTime.now(),
    );
  }

  void updateState(meal, int index) {
    setState(() {
      foodName = meal[index]['name'];
      calories = meal[index]['calories'];
      protein = meal[index]['protein'];
      fat = meal[index]['fat'];
      carb = meal[index]['carbs'];
      quantity = meal[index]['quantity'];
    });
  }

  void deleteFavourteItem(meal, int index, BuildContext context) {
    String? removedFood = meal[index]['name'];
    dbService.deleteFavouriteFromFirestoreUser(id: userId!, index: index);

    AuthenticationService.snackbar(removedFood! + " is removed from favourites",
        Icons.remove, Colors.red, context);
  }
}
