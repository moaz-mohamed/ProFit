import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:profit/widgets/IntroPage/Intro/login_screen.dart';

class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  static String message = "";
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
//signup with email and password
  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    User? _user;
    try {
      _user = (await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      _user!.updateDisplayName(name);
      message = 'Register success!';
     // message = _user.toString();
      // showMessage(message, context);
      users.doc(_user.uid).set({
        "name" : _user.displayName,
        "email" : _user.email,

      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message =
            'The account already exists for that email, try different email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is badly formatted.';
      } else {
        message = e.message!;
      }
     // message = _user.toString();
    }
    

  }

//---------------------------------------
//signin with email and password

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    
  }) async {
    User? _user;
    UserCredential? userCredential;
    
    try {
      _user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
         // _user.uid;s
      message = 'Login success!';
     // message = _user.toString();

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'No user found with the credential.';
      } else if (e.code == 'wrong-password') {
        message = 'The password is wrong.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is badly formatted.';
      } else {
        message = e.message!;
      }
  
    
    }
    
    
  }

  Future<void> signInWithGoogle(
   // {required BuildContext context}
    ) async {
    User? _user;

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
     
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
      // _user =  auth.currentUser;
       _user = userCredential.user;
     
       message = 'sign in with Google success';
     // message = _user.toString();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          message = e.code;
        } else if (e.code == 'invalid-credential') {
          message = e.code;
        }
      }
    }
   // message = _user.toString();
    
  }

  Future<void> signOut() async {
    await auth.signOut();
    
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }

  static Future<void> showMessage(String message, BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('ProFit Message'),
            content:Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Okay'),
              )
            ],
          );
        });
  }
}
