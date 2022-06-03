import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:profit/models/user_profile.dart';

class DatabaseService {
  // collection reference for tracker
  CollectionReference users = FirebaseFirestore.instance.collection('users');

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
    DocumentReference user =
        FirebaseFirestore.instance.collection("users").doc(id);
    await user.get().then((value) {
      burnedCaloriesTotal = value.get('burnedCalories');
    });
    burnedCaloriesTotal += burnedCalories;
    // update user document
    return await FirebaseFirestore.instance.collection('users').doc(id).update({
      'burnedCalories': burnedCaloriesTotal,
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
    ;

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

//UpdateBurnedCaloriesAfterDelete
  Future updateBurnedCaloriesAfterDelete(
      {required String id, required double burnedCalories}) async {
    double burnedCaloriesTotal = 0;
    DocumentReference user =
        FirebaseFirestore.instance.collection("users").doc(id);
    await user.get().then((value) {
      burnedCaloriesTotal = value.get('burnedCalories');
    });
    burnedCaloriesTotal -= burnedCalories;
    // update user document
    return await FirebaseFirestore.instance.collection('users').doc(id).update({
      'burnedCalories': burnedCaloriesTotal,
    });
  }
}
