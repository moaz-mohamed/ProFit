import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:profit/models/user_profile.dart';
import 'package:profit/utils/calculations/calculate_calories.dart';

class DatabaseService {
  // collection reference for tracker
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String? userId;
  String? updatedName;
  String? foodName;
  String? updatedWeight;
  String? updatedage;
  String? updatedheight;
  int? updatedGoal;
  double? updatedcalories;
  double? updatedRemainingCalories;
  double? updatedRemainingFats;
  double? updatedRemainingCarbs;
  double? updatedRemainingProtein;

  double? updatedActivityLevel;
  bool? updatedgender;

  Future createNewUser(
      {required String id, required UserProfile userProfile}) async {
    userProfile.remainingCalories = userProfile.calories;
    userProfile.remainingProteins = ((30 / 100) * userProfile.calories) / 4;
    userProfile.remainingFats = ((30 / 100) * userProfile.calories) / 9;
    userProfile.remainingCarbs = ((40 / 100) * userProfile.calories) / 4;

    return await users
        .doc(id)
        .set(userProfile.toMap(), SetOptions(merge: true));
  }

  Future resetMeals(String id) async {
    return await users.doc(id).update(
      {
        'totalCarbs': 0.0,
        'totalProteins': 0.0,
        'totalFats': 0.0,
        'lunch': [],
        'dinner': [],
        'breakfast': [],
        'eatenCalories': 0.0,
      },
    );
  }

  updateCalories() async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(userId);
    double? newRemainCalories;
    double? newRemainProtien;
    double? newRemainFats;
    double? newRemainCarbs;
    double? eatenCalories;
    double? totalFats;
    double? totalCarbs;
    double? totalProteins;
    double? burnedCalories;
    await docUser.get().then((value) {
      eatenCalories = value.get('eatenCalories');
      totalFats = value.get('totalFats');
      totalCarbs = value.get('totalCarbs');
      burnedCalories = value.get('burnedCalories') ?? 0;
      totalProteins = value.get('totalProteins');
    });
    double calories = CalculateCalories(updatedGoal, updatedage, updatedheight,
        updatedWeight, updatedgender, updatedActivityLevel);

    newRemainCalories = calories;
    newRemainProtien = ((30 / 100) * calories) / 4;
    newRemainFats = ((30 / 100) * calories) / 9;
    newRemainCarbs = ((40 / 100) * calories) / 4;
    docUser.update({
      'calories': calories,
      'remainingCalories': newRemainCalories - eatenCalories! + burnedCalories!,
      'remainingFats': newRemainFats - totalFats!,
      'remainingCarbs': newRemainCarbs - totalCarbs!,
      'remainingProteins': newRemainProtien - totalProteins!,
    });
  }

  Stream<DocumentSnapshot> getUserDocStream({required String id}) {
    return users.doc(id).snapshots();
  }

  Future addBreakfastToFirestoreUser(
      {required String id,
      required String name,
      required double calories,
      required double quantity,
      required double protein,
      required double fat,
      required double carbs}) async {
// get snapshot and update breakfast
    final DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    //printAllDataInDocument(id: id);

// update breakfast if exists else create new breakfast
    final List breakfast = user['breakfast'];
    breakfast.add({
      'name': name,
      'calories': calories,
      'quantity': quantity,
      'protein': protein,
      'fat': fat,
      'carbs': carbs,
    });
    updateUserCalories(
        id: id,
        foodCalories: calories,
        fats: fat,
        carbs: carbs,
        proteins: protein);
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'breakfast': breakfast});
  }

// Add lunch
  Future addLunchToFirestoreUser(
      {required String id,
      required String name,
      required double calories,
      required double quantity,
      required double protein,
      required double fat,
      required double carbs}) async {
// get snapshot and update breakfast
    final DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    //printAllDataInDocument(id: id);

    final List lunch = user['lunch'];
    lunch.add({
      'name': name,
      'calories': calories,
      'quantity': quantity,
      'protein': protein,
      'fat': fat,
      'carbs': carbs,
    });
    updateUserCalories(
        id: id,
        foodCalories: calories,
        fats: fat,
        carbs: carbs,
        proteins: protein);
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'lunch': lunch});
  }

// Add dinner
  Future addDinnerToFirestoreUser(
      {required String id,
      required String name,
      required double calories,
      required double quantity,
      required double protein,
      required double fat,
      required double carbs}) async {
// get snapshot and update breakfast
    final DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    //printAllDataInDocument(id: id);

    final List dinner = user['dinner'];
    dinner.add({
      'name': name,
      'calories': calories,
      'quantity': quantity,
      'protein': protein,
      'fat': fat,
      'carbs': carbs,
    });
    updateUserCalories(
        id: id,
        foodCalories: calories,
        fats: fat,
        carbs: carbs,
        proteins: protein);
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'dinner': dinner});
  }

// Add workout
  Future addWorkoutToFirestoreUser({
    required String id,
    required String name,
    required double burnedCalories,
    required double duration,
  }) async {
// get yser document snapshot
    final DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    //printAllDataInDocument(id: id);

// update workout if exists else create new workout
    final List workout = user['workout'];

    workout.add({
      'name': name,
      'burnedCalories': burnedCalories,
      'duration': duration,
    });

// update total burned calories
    updateTotalBurnedCalories(id: id, burnedCalories: burnedCalories);
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'workout': workout});
  }

  Future updateUserCalories(
      {required String id,
      required double foodCalories,
      required double fats,
      required double carbs,
      required double proteins}) async {
    double remainingCalories = 0;
    double eatenCalories = 0;
    double total_fats = 0;
    double total_carbs = 0;
    double total_proteins = 0;
    double remaining_fats = 0;
    double remaining_carbs = 0;
    double remaining_proteins = 0;

    DocumentReference user =
        FirebaseFirestore.instance.collection("users").doc(id);

    await user.get().then((value) {
      remainingCalories = value.get('remainingCalories');
      eatenCalories = value.get('eatenCalories');
      total_fats = value.get('totalFats');
      total_carbs = value.get('totalCarbs');
      total_proteins = value.get('totalProteins');
      remaining_fats = value.get('remainingFats');
      remaining_carbs = value.get('remainingCarbs');
      remaining_proteins = value.get('remainingProteins');
    });
    remainingCalories -= foodCalories;
    eatenCalories += foodCalories;
    total_fats += fats;
    total_carbs += carbs;
    total_proteins += proteins;
    remaining_fats -= fats;
    remaining_carbs -= carbs;
    remaining_proteins -= proteins;

    return await FirebaseFirestore.instance.collection('users').doc(id).update({
      'remainingCalories': remainingCalories,
      'eatenCalories': eatenCalories,
      'totalFats': total_fats,
      'totalCarbs': total_carbs,
      'totalProteins': total_proteins,
      'remainingFats': remaining_fats,
      'remainingCarbs': remaining_carbs,
      'remainingProteins': remaining_proteins,
    });
  }

// update burned calories
  Future updateTotalBurnedCalories(
      {required String id, required double burnedCalories}) async {
    double burnedCaloriesTotal = 0;
    late double remainingCalories;
    DocumentReference user =
        FirebaseFirestore.instance.collection("users").doc(id);
    await user.get().then((value) {
      burnedCaloriesTotal = value.get('burnedCalories');
      remainingCalories = value.get('remainingCalories');
    });
    burnedCaloriesTotal += burnedCalories;
    remainingCalories += burnedCalories;
    // update user document
    return await FirebaseFirestore.instance.collection('users').doc(id).update({
      'burnedCalories': burnedCaloriesTotal,
      'remainingCalories': remainingCalories,
    });
  }

  Future printAllDataInDocument({required String id}) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) {
      print(value.data().toString());
      // print type of data
      print(value.data().runtimeType);
    });
  }

  // delete meal with id and type
  Future deleteMealFromFirestoreUser(
      {required String id, required String type, required int index}) async {
    final DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('users').doc(id).get();

    final List mealType = user[type.toLowerCase()];

    double calories = mealType[index]['calories'];
    double fats = mealType[index]['fat'];
    double carbs = mealType[index]['carbs'];
    double proteins = mealType[index]['protein'];

    // update user calories

    updateUserCaloriesAfterDelete(
        id: id,
        foodCalories: calories,
        fats: fats,
        carbs: carbs,
        proteins: proteins);
    // remove meal from list
    mealType.removeAt(index);
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({type.toLowerCase(): mealType});
  }

// update user calories after delete
  Future updateUserCaloriesAfterDelete(
      {required String id,
      required double foodCalories,
      required double fats,
      required double carbs,
      required double proteins}) async {
    double remainingCalories = 0;
    double eatenCalories = 0;
    double total_fats = 0;
    double total_carbs = 0;
    double total_proteins = 0;
    double remaining_fats = 0;
    double remaining_carbs = 0;
    double remaining_proteins = 0;

    DocumentReference user =
        FirebaseFirestore.instance.collection("users").doc(id);

    await user.get().then((value) {
      remainingCalories = value.get('remainingCalories');
      eatenCalories = value.get('eatenCalories');
      total_fats = value.get('totalFats');
      total_carbs = value.get('totalCarbs');
      total_proteins = value.get('totalProteins');
      remaining_fats = value.get('remainingFats');
      remaining_carbs = value.get('remainingCarbs');
      remaining_proteins = value.get('remainingProteins');
    });
    remainingCalories += foodCalories;
    eatenCalories -= foodCalories;
    total_fats -= fats;
    total_carbs -= carbs;
    total_proteins -= proteins;
    remaining_fats += fats;
    remaining_carbs += carbs;
    remaining_proteins += proteins;

    return await FirebaseFirestore.instance.collection('users').doc(id).update({
      'remainingCalories': remainingCalories,
      'eatenCalories': eatenCalories,
      'totalFats': total_fats,
      'totalCarbs': total_carbs,
      'totalProteins': total_proteins,
      'remainingFats': remaining_fats,
      'remainingCarbs': remaining_carbs,
      'remainingProteins': remaining_proteins,
    });
  }

// DeleteWorkoutFromFireStoreUser
  Future deleteWorkoutFromFirestoreUser(
      {required String id,
      required int index,
      required double calories}) async {
    final DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('users').doc(id).get();

    final List workout = user['workout'];

    // update Burned Calories after delete
    updateBurnedCaloriesAfterDelete(id: id, burnedCalories: calories);
    // remove meal from list
    workout.removeAt(index);
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'workout': workout});
  }

  // make function that takes food and calories and add them to user favorite list

  Future addFoodToFavoriteList(
      {required String id,
      required int index,
      required String name,
      required double calories,
      required double fats,
      required double quantity,
      required double carbs,
      required double proteins}) async {
    final DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    final List favoriteFoods = user['favourites'];

    favoriteFoods.add({
      'name': name,
      'calories': calories,
      'fat': fats,
      'carbs': carbs,
      'protein': proteins,
      'quantity': quantity,
    });

    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'favourites': favoriteFoods});
  }
//Future addBreakfastToFirestoreUser(
//       {required String id,
//       required String name,
//       required double calories,
//       required double quantity,
//       required double protein,
//       required double fat,
//       required double carbs}) async {
// // get snapshot and update breakfast
//     final DocumentSnapshot user =
//         await FirebaseFirestore.instance.collection('users').doc(id).get();
//     //printAllDataInDocument(id: id);

// // update breakfast if exists else create new breakfast
//     final List breakfast = user['breakfast'];
//     breakfast.add({
//       'name': name,
//       'calories': calories,
//       'quantity': quantity,
//       'protein': protein,
//       'fat': fat,
//       'carbs': carbs,
//     });
//     updateUserCalories(
//         id: id,
//         foodCalories: calories,
//         fats: fat,
//         carbs: carbs,
//         proteins: protein);
//     return await FirebaseFirestore.instance
//         .collection('users')
//         .doc(id)
//         .update({'breakfast': breakfast});
//   }

//UpdateBurnedCaloriesAfterDelete
  Future updateBurnedCaloriesAfterDelete(
      {required String id, required double burnedCalories}) async {
    double burnedCaloriesTotal = 0;
    late double remainingCalories;
    DocumentReference user =
        FirebaseFirestore.instance.collection("users").doc(id);
    await user.get().then((value) {
      burnedCaloriesTotal = value.get('burnedCalories');
      remainingCalories = value.get('remainingCalories');
    });
    burnedCaloriesTotal -= burnedCalories;
    remainingCalories -= burnedCalories;
    // update user document
    return await FirebaseFirestore.instance.collection('users').doc(id).update({
      'burnedCalories': burnedCaloriesTotal,
      'remainingCalories': remainingCalories,
    });
  }

  getFields() async {
    userId = auth.currentUser!.uid;
    final docUser = FirebaseFirestore.instance.collection('users').doc(userId);
    await docUser.get().then((value) {
      updatedName = value.get('name').toString();
      updatedWeight = value.get('weight').toString();
      updatedage = value.get('age').toString();
      updatedheight = value.get('height').toString();
      updatedGoal = value.get('goal');
      updatedgender = value.get('gender');
      updatedcalories = value.get('calories');
      updatedActivityLevel = value.get('activityLevel');
      updatedRemainingCalories = value.get('remainingCalories');
      updatedRemainingCarbs = value.get('remainingCarbs');
      updatedRemainingFats = value.get('remainingFats');
      updatedRemainingProtein = value.get('remainingProteins');
    });
  }

  getFavourites() async {
    userId = auth.currentUser!.uid;
    final docUser = FirebaseFirestore.instance.collection('users').doc(userId);

    await docUser.get().then((value) {
      foodName = value.get('foodName').toString();
    });
  }
  // make function that retrieves food name and calories from favorite list from firestore

  Future getFavouriteFoods() async {
    List favouriteFoods = [];

    userId = auth.currentUser!.uid;
    final docUser = FirebaseFirestore.instance.collection('users').doc(userId);
    await docUser.get().then((value) {
      return favouriteFoods = value.get('favourites');
    });
  }

  deleteFavouriteFromFirestoreUser(
      {required String id, required int index}) async {
    final DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    final List favourite = user['favourites'];
    favourite.removeAt(index);
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'favourites': favourite});
  }

  getDateFromFirestore(String id) async {
    late Timestamp date;
    final DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    date = user.get('date') as Timestamp;
    return date.toDate();
  }

// reset all data
  resetAllData(String id) async {
    // get calories from firestore
    final DocumentSnapshot user =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    final double calories = user.get('calories');
    final double remainingCarbs = user.get('remainingCarbs');
    final double remainingFats = user.get('remainingFats');
    final double remainingProtein = user.get('remainingProteins');

    return await users.doc(id).update(
      {
        'totalCarbs': 0.0,
        'totalProteins': 0.0,
        'totalFats': 0.0,
        'lunch': [],
        'dinner': [],
        'breakfast': [],
        'workout': [],
        'eatenCalories': 0.0,
        'burnedCalories': 0.0,
        'remainingCalories': calories,
        'remainingCarbs': ((40 / 100) * calories) / 4,
        'remainingFats': ((30 / 100) * calories) / 9,
        'remainingProteins': ((30 / 100) * calories) / 4,
      },
    );
  }

// update date of user id
  updateDate(String id, DateTime date) async {
    return await users.doc(id).update({
      'date': Timestamp.fromDate(date),
    });
  }
}
