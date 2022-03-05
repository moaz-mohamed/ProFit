import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profit/widgets/Dashboard/Screens/geofencing.dart';
import 'package:profit/widgets/Dashboard/Screens/home_screen.dart';
import 'package:profit/widgets/Dashboard/Screens/food_screen.dart';
import 'package:profit/widgets/Dashboard/Screens/workouts_screen.dart';
import 'package:profit/widgets/Dashboard/NavigationBloc/tab_bar_bloc.dart';
import 'package:profit/widgets/Dashboard/NavigationBloc/tab_bar_event.dart';

class TabBarPage extends StatelessWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TabBarBloc>(
      create: (BuildContext context) => TabBarBloc(1),
      child: BlocBuilder<TabBarBloc, int>(
        builder: (context, state) {
          final bloc = BlocProvider.of<TabBarBloc>(context);
          return Scaffold(
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
      fixedColor: Colors.blueAccent,
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        const BottomNavigationBarItem(
          icon: Image(
            image: AssetImage('assets/images/workouts.png'),
          ),
          label: 'Workout',
        ),
        const BottomNavigationBarItem(
          icon: Image(
            image: AssetImage('assets/images/home.png'),
          ),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Image(
            image: AssetImage('assets/images/food.png'),
          ),
          label: 'Food',
        ),
        const BottomNavigationBarItem(
          icon: Image(
            image: AssetImage('assets/images/geofence.png'),
          ),
          label: 'GeoFencing',
        ),
      ],
      onTap: (index) {
        bloc.add(NavBarTappedEvent(
            index: index)); //trigger and notifies the bloc a new event
      },
    );
  }

  Widget _createBody(BuildContext context, int index) {
    final children = [WorkoutsPage(), HomePage(), FoodScreen(), GeoFencing()];
    return children[index];
  }
}
