import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:profit/services/firestore_database.dart';

class MyHeaderDrawer extends StatefulWidget {
  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  FirebaseAuth auth = FirebaseAuth.instance;

  String username = "";
  String useremail = "";
  getData() async {
    String? name;
    String? email;

    String userId = auth.currentUser!.uid;
    DocumentReference doc =
        FirebaseFirestore.instance.collection("users").doc(userId);
    DatabaseService dbService = DatabaseService();

    await dbService.getFields();

    await doc.get().then((value) {
      name = value.get('name').toString();
      email = value.get('email').toString();
    });

    //setState(() => username = name!);
    setState(() {
      username = name!;
      useremail = email!;
    });
    // setState(() => useremail = email!);
  }

  @override
  void initState() {
    getData();
    // getData('email');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[700],
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/dashboard/user.png'),
              ),
            ),
          ),
          Text(
            'Welcome ' + username,
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
          Text(
            useremail,
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
