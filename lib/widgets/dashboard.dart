import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard(
      {Key? key,
      required this.goalAchieved,
      required this.ageController,
      required this.heightController,
      required this.weightController,
      required this.gender,
      required this.activityLevel})
      : super(key: key);
  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController ageController;
  final int goalAchieved;
  final bool gender;
  final double activityLevel;
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
