import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:profit/models/user_profile.dart';

class DatabaseService {
  // collection reference for tracker
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future createNewUser(
      {required String id, required UserProfile userProfile}) async {
    userProfile.remainingCalories = userProfile.calories;

    return await users
        .doc(id)
        .set(userProfile.toMap(), SetOptions(merge: true));
  }
}

// Add breakfast
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

  return await FirebaseFirestore.instance
      .collection('users')
      .doc(id)
      .update({'dinner': dinner});
}

// print all data in a document in firestore
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
