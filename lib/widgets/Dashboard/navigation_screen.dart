import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/home_screen.dart';
import 'package:profit/widgets/Dashboard/Screens/food_recommendation_screen.dart';
import 'package:profit/widgets/Dashboard/Screens/geofencing.dart';
import 'package:profit/widgets/Dashboard/Screens/food_screen.dart';
import 'package:profit/widgets/Dashboard/Screens/workouts_screen.dart';
import 'package:profit/widgets/Dashboard/NavigationBloc/tab_bar_bloc.dart';
import 'package:profit/widgets/Dashboard/NavigationBloc/tab_bar_event.dart';
import 'package:profit/themes/ThemeUI.dart';

class TabBarPage extends StatelessWidget {
  const TabBarPage({Key? key}) : super(key: key);

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
            ),
            body: _createBody(context,
                bloc.currentIndex), //return the index of the screen i want to route
            bottomNavigationBar: _createdBottomTabBar(context),
          );
        },
      ),
    );
  }

  Widget _createdBottomTabBar(BuildContext context) {
    final bloc = BlocProvider.of<TabBarBloc>(context);
    return BottomNavigationBar(
      currentIndex: bloc.currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/dashboard/home.png', scale: 2.6,),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/dashboard/food.png', scale: 2.6,),
          label: 'Food',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/dashboard/workout.png', scale: 2.6,),
          label: 'Workout',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/dashboard/geofence.png', scale: 2.6,),
          label: 'GeoFence' , 
        ),
         BottomNavigationBarItem(
          icon: Image.asset('assets/dashboard/food_recommendation.png', scale: 2.6,),
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
    final children = [HomePageOFF(),FoodScreen(), WorkoutsPage(), GeoFencing(),FoodReccomendationScreen()];
    return children[index];
  }
}
