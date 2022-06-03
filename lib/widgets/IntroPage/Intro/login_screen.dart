import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:profit/services/validate.dart';
import 'package:profit/services/auth.dart';
import 'package:profit/themes/ThemeUI.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formGlobalKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final AuthenticationService authServices = AuthenticationService();

  final FirebaseAuth auth = FirebaseAuth.instance;

  checkAuthentication() async {
    auth.userChanges().listen((User? user) {
      if (user != null) {
        Navigator.pushNamed(context, '/success');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //  final formGlobalKey = GlobalKey<FormState>();

    void signIn() async {
      final formKey = formGlobalKey.currentState;
      if (formKey!.validate()) {
        formKey.save();
        await authServices.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passController.text);

        AuthenticationService.showMessage(
            AuthenticationService.message, context);
      }

      await checkAuthentication();
    }

    void signInWithGoogle() async {
      await authServices.signInWithGoogle();

      AuthenticationService.showMessage(AuthenticationService.message, context);
      await checkAuthentication();
    }

    return Scaffold(
      backgroundColor: FitnessAppTheme.selectorGrayBackGround,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: FitnessAppTheme.selectorGrayBackGround,
        // ignore: prefer_const_constructors
        title: Text('Login to ProFit',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: FitnessAppTheme.fontName,
                color: Colors.black)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                // ignore: prefer_const_constructors
                Text(
                  'Welcome to ProFit, Login to continue',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: _emailController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
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
                const SizedBox(height: 40),
                TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                    hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    icon: Icon(
                      Icons.lock,
                      color: FitnessAppTheme.nearlyBlue,
                    ),
                  ),
                  validator: (value) {
                    if (!Validators.validatePassword(value!)) {
                      return "Enter Correct Password";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                    child: const Text('LOGIN'),
                    onPressed: () {
                      snackbar(' Processing ....');
                      signIn();
                    },
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
                SignInButton(
                  Buttons.Google,
                  onPressed: signInWithGoogle,
                  elevation: 20,
                ),
                const SizedBox(height: 20),
              ],
            ),
            key: formGlobalKey,
          ),
        ),
      ),
    );
  }

  void snackbar(String text) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Row(
        children: [
          const Icon(
            Icons.info_outlined,
            size: 32,
            color: Colors.blue,
          ),
          Text(text),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
