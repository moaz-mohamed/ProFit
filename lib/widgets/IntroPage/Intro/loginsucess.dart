import 'package:flutter/material.dart';
import 'package:profit/services/auth.dart';
import 'package:profit/services/firestore_database.dart';
import 'package:profit/themes/ThemeUI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:profit/widgets/IntroPage/Intro/login_screen.dart';
// import firestore

class Sucess extends StatefulWidget {
  @override
  State<Sucess> createState() => _SucessState();
}

class _SucessState extends State<Sucess> {
  AuthenticationService authServices = AuthenticationService();

  FirebaseAuth auth = FirebaseAuth.instance;

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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: FitnessAppTheme.selectorGrayBackGround,
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text('Signed in',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  const Text(
                    'Welcome to your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 40),
                  //make a button with on click function
                  ElevatedButton(
                    onPressed: () {
                      AddDinnerToFirestoreUser(
                          id: FirebaseAuth.instance.currentUser!.uid,
                          name: "lunch23",
                          calories: 2.1,
                          quantity: 3.2,
                          protein: 777.7,
                          fat: 5.5,
                          carbs: 6.2);
                    },
                    child: Text('Add Meals to Current User'),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                      child: const Text('Signout'),
                      onPressed: signout,
                      style: ElevatedButton.styleFrom(
                        primary: FitnessAppTheme.nearlyBlue,
                        elevation: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        fixedSize: const Size(130, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      )),
                  const SizedBox(height: 40),
                  ElevatedButton(
                      child: const Text('Signout google'),
                      onPressed: signout,
                      style: ElevatedButton.styleFrom(
                        primary: FitnessAppTheme.nearlyBlue,
                        elevation: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        fixedSize: const Size(130, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
