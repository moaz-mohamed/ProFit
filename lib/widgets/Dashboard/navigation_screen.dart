import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profit/main.dart';
import 'package:profit/services/food_recommendation.dart';
import 'package:profit/widgets/Dashboard/Screens/Geofencing/geofencing.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/first_dashboard.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/home_screen.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/workout_screen.dart';
import 'package:profit/widgets/Dashboard/Screens/FoodRecommendationScreen/recommendation_input.dart';
import 'package:profit/widgets/Dashboard/Screens/steps_screen.dart';
import 'package:profit/widgets/Dashboard/Screens/WorkoutScreen/workout_screen.dart';
import 'package:profit/widgets/Dashboard/NavigationBloc/tab_bar_bloc.dart';
import 'package:profit/widgets/Dashboard/NavigationBloc/tab_bar_event.dart';
import 'package:profit/themes/ThemeUI.dart';
import 'package:profit/widgets/IntroPage/intro_main.dart';
import 'package:profit/widgets/IntroPage/Intro/login_screen.dart';

import 'package:profit/widgets/IntroPage/Intro/login_screen.dart';
import 'package:profit/widgets/IntroPage/Intro/onboarding_screen.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> {
  checkAuthentication() async {
    FirebaseAuth.instance.authStateChanges().listen((_user) {
      if (_user == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MyApp()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBarBloc>(
      create: (BuildContext context) => TabBarBloc(0),
      child: BlocBuilder<TabBarBloc, int>(
        builder: (context, state) {
          final bloc = BlocProvider.of<TabBarBloc>(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("ProFit"),
              actions: [
                Row(
                  children: [
                    Text("logout"),
                    IconButton(
                        icon: const Icon(Icons.logout_rounded),
                        onPressed: () {
                          _signOut();
                          FirebaseAuth.instance
                              .authStateChanges()
                              .listen((User? user) {
                            if (user == null) {
                              print('User is currently signed out!');
                            } else {
                              print('User is signed in!');
                            }
                          });

                          checkAuthentication();
                        }),
                  ],
                )
              ],
            ),
            body: _createBody(context,
                bloc.currentIndex), //return the index of the screen i want to route
            backgroundColor: Colors.white,
            bottomNavigationBar: _createdBottomTabBar(context),
          );
        },
      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Widget _createdBottomTabBar(BuildContext context) {
    final bloc = BlocProvider.of<TabBarBloc>(context);
    return BottomNavigationBar(
      currentIndex: bloc.currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/dashboard/home.png',
            scale: 2.6,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/dashboard/shoe.png',
            scale: 2,
          ),
          label: 'Steps',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/dashboard/workout.png',
            scale: 2.6,
          ),
          label: 'Workout',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/dashboard/geofence.png',
            scale: 2.6,
          ),
          label: 'GeoFence',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/dashboard/food_recommendation.png',
            scale: 2,
          ),
          label: "Recommend",
        ),
      ],
      selectedLabelStyle: FitnessAppTheme.navScreen,
      fixedColor: Colors.blue,
      onTap: (index) {
        bloc.add(NavBarTappedEvent(
            index: index)); //trigger and notifies the bloc a new event
      },
    );
  }

  Widget _createBody(BuildContext context, int index) {
    final children = [
      HomePage(),
      StepsScreen(),
      WorkoutsPage(),
      Geofencing(),
      FoodRecommendationScreen()
    ];
    return children[index];
  }
}
