import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:profit/services/firestore_database.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  TextEditingController _nameController = TextEditingController();
  // TextEditingController _genderController = TextEditingController();
  // TextEditingController _ageController = TextEditingController();

  // List userProfilesList = [];

  // String userID = "";

  FirebaseAuth auth = FirebaseAuth.instance;
  String username = "";
  String useremail = "";
  String userage = "";

  getData() async {
    String? name;
    String? email;
    String? age;
    String userId = auth.currentUser!.uid;
    DocumentReference doc =
        FirebaseFirestore.instance.collection("users").doc(userId);

    await doc.get().then((value) {
      name = value.get('name').toString();
      email = value.get('email').toString();
      age = value.get('age').toString();
    });

    setState(() => username = name!);
    setState(() => useremail = email!);
    setState(() => userage = age!);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  // fetchuserdata() async {
  //    await doc.get().then((value) {
  //     name = value.get('name').toString();
  //     email = value.get('email').toString();
  //   });
  //   if (username == null) {
  //     print('Unable to retrieve');
  //   } else {
  //     setState(() {
  //       username = name!;
  //     });
  //   }
  // }

  // updateData(String name, String userID) async {
  //   await DatabaseService().updateUserList(name, userID);
  //   // fetchDatabaseList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My info"),
          automaticallyImplyLeading: false,
        ),
        body: ListView(children: <Widget>[
          Card(
            child: ListTile(
              title: Text("Name"),
              subtitle: Text(username),
              leading: const CircleAvatar(
                  // child: Image(
                  //   image: AssetImage('assets/Profile_Image.png'),
                  // ),
                  ),
              //  trailing: Text('${userProfilesList[index]['score']}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Email"),
              subtitle: Text(useremail),
              leading: const CircleAvatar(
                backgroundColor: Colors.red,
              ),
              //  trailing: Text('${userProfilesList[index]['score']}'),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("Age"),
              subtitle: Text(userage),
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
              ),
            ),
          ),
        ]));
  }
}
