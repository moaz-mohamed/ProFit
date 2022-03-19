import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:profit/services/auth.dart';
import 'package:profit/services/firestore_database.dart';
import 'package:profit/themes/ThemeUI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/first_dashboard.dart';
import 'package:profit/widgets/Dashboard/navigation_screen.dart';
import 'package:profit/widgets/IntroPage/Intro/login_screen.dart';
// import dashboard from './dashboard';

// import firestore

class Sucess extends StatefulWidget {
  @override
  State<Sucess> createState() => _SucessState();
}

class _SucessState extends State<Sucess> {
  AuthenticationService authServices = AuthenticationService();
  DatabaseService databaseService = DatabaseService();
  FirebaseAuth auth = FirebaseAuth.instance;
  String username = "";
  String userCalories = "";
  checkAuthentication() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        // Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => true);
        // Navigator.pop(context);
        // Navigator.pushReplacementNamed(context, '/login');

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return LoginScreen();
        //     },
        //   ),
        // );
        //  Navigator.removeRoute(context, (Route<dynamic> route) => false)
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          ModalRoute.withName('/sucess'),
        );
        // Navigator.of(context).popUntil(ModalRoute.withName('/sucess'));

        //   Navigator.pushNamedAndRemoveUntil
        //Navigator.pushNamedAndRemoveUntil(context, '/login', ModalRoute.withName('/success'));

//Navigator.of(context).pushNamedAndRemoveUntil('/login', ModalRoute.withName('/success'));
//Navigator.push(context,  MaterialPageRoute(builder: (context) => LoginScreen()));

      }
    });
  }

  // checkAuthenticationGoogle() async {
  //   User? googleUser = await auth.currentUser;

  //   // user = userCredential.user;
  //   if (googleUser == null) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) {
  //           return const LoginScreen();
  //         },
  //       ),
  //     );
  //   }
  // }
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  void signout() async {
    await authServices.signOutGoogle();
    await authServices.signOut();
    await checkAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            backgroundColor: FitnessAppTheme.selectorGrayBackGround,
            body: TabBarPage()));
  }
}
