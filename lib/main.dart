// import 'package:calory_calc/blocs/auth/bloc.dart';
// import 'package:calory_calc/providers/local_providers/userProvider.dart';

// import 'package:calory_calc/models/dbModels.dart';
// import 'package:calory_calc/utils/dataLoader.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'widgets/forms/forms.dart';

import 'package:flutter/material.dart';
import 'package:profit/widgets/onboarding_screen.dart';
import 'package:profit/widgets/activity_level.dart';
import 'package:profit/widgets/goal_achieved_form.dart';
import 'package:profit/widgets/physical_paramters_form.dart';

import 'design/ThemeUI.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter App',
      home: IntroPage(),
    );
  }
}

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final _pageController =
      PageController(); //It controls the pages of the physical paramters input entry.
  // final _nameController = TextEditingController();
  // final _surnameController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();
  late double
      _activityLevel; //It represents the fitness workmodel that will be included in the BMR calculation(workmodel)
  late int
      _goalAchieved; //It represents the goal of the user whether it is to lose/maintenance/build muscle.
  late bool _gender; //Male or Female

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(
          FocusNode(),
        );
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(backgroundColor: FitnessAppTheme.background),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the HomeScreen widget.
          '/': (context) => OnBoardingScreen(),
          '/goal': (context) => GoalAchievedForm(
                // It is the form of the users goal whether it to lose/maintenance/build muscle.
                onComplete: (int goalAchieved) {
                  setState(() => _goalAchieved = goalAchieved);
                  // _advancingNextPage();
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
              }),
        },
      ),
    );
  }

  // void registrationAtLocalDB(User user) {
  //   BlocProvider.of<AuthBloc>(context).add(Authorize(user: user));
  // }

}
