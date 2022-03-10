import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:profit/themes/ThemeUI.dart';
import 'package:profit/utils/calculations/calculate_calories.dart';
import 'package:profit/widgets/IntroPage/Intro/activity_level.dart';
import 'package:profit/widgets/IntroPage/Intro/goal_achieved_form.dart';
import 'package:profit/widgets/IntroPage/Intro/login_screen.dart';
import 'package:profit/widgets/IntroPage/Intro/loginsucess.dart';
import 'package:profit/widgets/IntroPage/Intro/onboarding_screen.dart';
import 'package:profit/widgets/IntroPage/Intro/physical_paramters_form.dart';
import 'package:profit/widgets/IntroPage/Intro/signup_screen.dart';
import 'package:profit/widgets/Dashboard/navigation_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: const IntroPage(),
      splash: 'assets/splash/Logo.png',
      //duration: ,
      splashTransition: SplashTransition.fadeTransition,
      //animationDuration: ,
      //pageTransitionType: ,
    );
  }
}

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  // final _pageController =
  //     PageController(); //It controls the pages of the physical paramters input entry.
  // final _nameController = TextEditingController();
  // final _surnameController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();
  late double
      _activityLevel; //It represents the fitness workmodel that will be included in the BMR calculation(workmodel)
  late int
      _goalAchieved; //It represents the goal of the user whether it is to lose/maintenance/build muscle.
  late bool _gender;
  late double calories;
  //Male or Female

  checkAuthentication() async {
    FirebaseAuth.instance.authStateChanges().listen((_user) {
      if (_user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return TabBarPage();
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    checkAuthentication();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(
          FocusNode(),
        );
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(backgroundColor: FitnessAppTheme.background),
        // i want a boolean from DB of authenticate or not to change my inital route
        initialRoute: '/',

        routes: {
          // When navigating to the "/" route, build the HomeScreen widget.
          '/': (context) => OnBoardingScreen(),
          '/goal': (context) => GoalAchievedForm(
                // It is the form of the users goal whether it to lose/maintenance/build muscle.
                onComplete: (int goalAchieved) {
                  setState(() => _goalAchieved = goalAchieved);
                },
              ),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/physical': (context) => PhysicalParametersForm(
                //It is the form widget responsible for taking the user age,height,weight
                ageController: _ageController,
                heightController: _heightController,
                weightController: _weightController,
                onCompleted: (
                  String weight,
                  String height,
                  String age,
                  bool gender,
                ) {
                  setState(() => _gender = gender);
                },
              ),
          '/activity': (context) =>
              ActivityLevelForm(onComplete: (double level) {
                setState(() => _activityLevel = level);
                calories = CalculateCalories(
                    _goalAchieved,
                    _ageController,
                    _heightController,
                    _weightController,
                    _gender,
                    _activityLevel);
              }),
          '/login': (context) => LoginScreen(),

          '/signup': (context) => SignupScreen(
                age: _ageController.text,
                activityLevel: _activityLevel,
                calories: calories,
                gender: _gender,
                weight: _weightController.text,
                goal: _goalAchieved,
                height: _heightController.text,
              ),
          '/success': (context) => TabBarPage(),
        },
      ),
    );
  }
}
