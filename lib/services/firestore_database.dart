import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:profit/models/user_profile.dart';

class DatabaseService {
  // collection reference for tracker
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future createNewUser(
      {required String id, required UserProfile userProfile}) async {
    userProfile.remainingCalories = userProfile.calories;

    return await users
        .doc(id)
        .set(userProfile.toMap(), SetOptions(merge: true));
  }

  Future AddBreakfastToFirestoreUser(
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
    updateUserCalories(id: id, foodCalories: calories); //Adding this function
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'breakfast': breakfast});
  }

// Add lunch
  Future AddLunchToFirestoreUser(
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
    updateUserCalories(id: id, foodCalories: calories);
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'lunch': lunch});
  }

// Add dinner
  Future AddDinnerToFirestoreUser(
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
    updateUserCalories(id: id, foodCalories: calories); //Adding this function
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'dinner': dinner});
  }

// Add workout
  Future AddWorkoutToFirestoreUser({
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

    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'workout': workout});
  }

  Future updateUserCalories(
      {required String id, required double foodCalories}) async {
    double remainingCalories = 0;
    double eatenCalories = 0;
    DocumentReference user =
        FirebaseFirestore.instance.collection("users").doc(id);

    await user.get().then((value) {
      remainingCalories = value.get('remainingCalories');
      eatenCalories = value.get('eatenCalories');
    });
    remainingCalories -= foodCalories;
    eatenCalories += foodCalories;

    return await FirebaseFirestore.instance.collection('users').doc(id).update({
      'remainingCalories': remainingCalories,
      'eatenCalories': eatenCalories,
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
}
// print all data in a document in firestore

 





