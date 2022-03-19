import 'package:flutter/material.dart';

import 'package:profit/themes/ThemeUI.dart';

class CustomMealText extends StatelessWidget {
  final String text;
  List<String> splittedMeal = [];
  CustomMealText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    splittedMeal = text.toString().split(" ");
    return splittedMeal.length > 3
        ? Column(
            children: [
              Card(
                margin: EdgeInsets.all(3),
                elevation: 1,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: FitnessAppTheme.nearlyWhite, width: 1)),
                child: ListTile(
                  title: Text(splittedMeal[0] + " " + splittedMeal[1]),
                  subtitle: Text(splittedMeal[2] +
                      " kCal" +
                      ", " +
                      splittedMeal[3] +
                      " gm"),
                ),
              ),
            ],
          )
        : Column(
            children: [
              Card(
                margin: EdgeInsets.all(3),
                elevation: 1,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: FitnessAppTheme.nearlyWhite, width: 1)),
                child: ListTile(
                  title: Text(splittedMeal[0]),
                  subtitle: Text(splittedMeal[1] +
                      " kCal" +
                      ", " +
                      splittedMeal[2] +
                      " gm"),
                ),
              ),
            ],
          );
  }
}
