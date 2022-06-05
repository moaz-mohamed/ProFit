import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:profit/models/user_profile.dart';
import 'package:profit/services/auth.dart';
import 'package:profit/services/firestore_database.dart';
import 'package:profit/services/validate.dart';
import 'package:profit/themes/ThemeUI.dart';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:profit/widgets/IntroPage/Intro/login_screen.dart';
import 'package:profit/widgets/IntroPage/Intro/loginsucess.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen(
      {Key? key,
      required this.goal,
      required this.age,
      required this.height,
      required this.weight,
      required this.gender,
      required this.activityLevel,
      required this.calories})
      : super(key: key);

  final int goal;
  final String age;
  final String height;
  final String weight;
  final bool gender;
  final double activityLevel;
  final double calories;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formGlobalKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final AuthenticationService authServices = AuthenticationService();
  final DatabaseService databaseService = DatabaseService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  User? _user;

  @override
  Widget build(BuildContext context) {
    final int _goal = widget.goal;
    final String _age = widget.age;
    final String _height = widget.height;
    final String _weight = widget.weight;
    final bool _gender = widget.gender;
    final double _activityLevel = widget.activityLevel;
    final double _calories = widget.calories;
    //  final formGlobalKey = GlobalKey<FormState>();
    final UserProfile userProfile = UserProfile({
      'name': _nameController.text,
      'email': _emailController.text,
      'goal': _goal,
      'age': _age,
      'height': _height,
      'weight': _weight,
      'gender': _gender,
      'activityLevel': _activityLevel,
      'calories': _calories,
    });

    void signup() async {
      final formKey = formGlobalKey.currentState;

      if (formKey!.validate()) {
        formKey.save();
        await authServices.signUpWithEmailAndPassword(
            name: _nameController.text,
            email: _emailController.text.trim(),
            password: _passController.text,
            confirmPassword: _confirmPassController.text);

        await databaseService.createNewUser(
            id: auth.currentUser!.uid, userProfile: userProfile);
      }
    }

    return Scaffold(
        backgroundColor: FitnessAppTheme.selectorGrayBackGround,
        appBar: AppBar(
          backgroundColor: FitnessAppTheme.selectorGrayBackGround,
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text('Create New Account',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Form(
                key: formGlobalKey,
                child: Column(children: [
                  TextFormField(
                    controller: _emailController,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      labelText: "Email",
                      hintText: "Enter your Email",
                      hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      icon: Icon(
                        Icons.email,
                        color: FitnessAppTheme.nearlyBlue,
                      ),
                      //border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (!Validators.validateEmail(value!.trim())) {
                        return "Enter Correct Email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    obscureText: false,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Enter your Name",
                      hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                      labelText: "Name",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      icon: Icon(
                        Icons.person,
                        color: FitnessAppTheme.nearlyBlue,
                      ),
                    ),
                    validator: (value) {
                      if (!Validators.validateName(value!)) {
                        return "Enter Correct Name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _passController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Enter your Password",
                      hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      icon: Icon(
                        Icons.lock,
                        color: FitnessAppTheme.nearlyBlue,
                      ),
                    ),
                    //controller: _pass,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (!Validators.validatePassword(value!)) {
                        return "Enter Correct Password";
                      } else {
                        // print(_pass.text);
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                      controller: _confirmPassController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        labelText: "Re-Password",
                        hintText: "Re-Enter your Password",
                        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                        labelStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        icon: Icon(
                          Icons.lock,
                          color: FitnessAppTheme.nearlyBlue,
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val!.isEmpty) return 'Enter Correct Password';
                        if (val != _passController.text) return 'Not Match';
                        return null;
                      }),
                  //  const SizedBox(height: 120),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      child:
                          const Text('Sign Up', style: TextStyle(fontSize: 24)),
                      onPressed: () async {
                        signup();
                        await Future.delayed(Duration(seconds: 2));
                        if (AuthenticationService.message ==
                            "Register success!") {
                          AuthenticationService.snackbar(
                              AuthenticationService.message,
                              Icons.verified,
                              Colors.green,
                              context);
                        } else if (AuthenticationService.message ==
                            ('The account already exists for that email, try different email.')) {
                          AuthenticationService.snackbar(
                              AuthenticationService.message,
                              Icons.warning_amber,
                              Colors.amber,
                              context);
                        }
                        await Future.delayed(Duration(seconds: 8));

                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        primary: FitnessAppTheme.nearlyBlue,
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const LoginScreen();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      'Already have an Account? Login',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ])),
          ),
        ));
  }
}
