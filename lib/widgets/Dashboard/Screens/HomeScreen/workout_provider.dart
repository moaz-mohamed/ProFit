import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/workout_cubit/workout_cubit.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/workout_screen.dart';

class WorkoutProvider extends StatelessWidget {
  const WorkoutProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: BlocProvider(
          create: (context) => WorkoutCubit(),
          child: WorkoutScreen(),
        )));
  }
}
