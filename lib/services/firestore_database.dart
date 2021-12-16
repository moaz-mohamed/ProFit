
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:profit/models/user_profile.dart';

class DatabaseService {
 // final String uid;

 // DatabaseService({required this.uid});

  // collection reference for tracker
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  // TODO: should use enum
  // TODO: fix meal representation
  // TODO: coupled with tracker
  // Future createNewUser({required String id ,required String name, 
  //           required  String email,required int goal,
  //             required String age, required String height,required String weight, required bool gender , required double activityLevel, required double calories}) async {
   
  //   return await users.doc(id).set({
  //     'name': name,
  //     'email': email,
  //     'goal': goal,
  //     'age': age,
  //     'height': height,
  //     'weight': weight,
  //     'gender': gender,
  //     'activityLevel': activityLevel,
  //     'calories': calories,
  //    },SetOptions(merge: true)
  //    );
  // }
   Future createNewUser({required String id ,required UserProfile userProfile}) async {

    return await users.doc(id).set(
    userProfile.toMap()
     ,SetOptions(merge: true)
     );
  }

// createNewUser(uid , ///         /// )
  //doc(user.id)
  //setData()
// }
}

//delete user , update