import 'package:flutter/material.dart';

import 'package:profit/themes/ThemeUI.dart';

class CustomWorkoutText extends StatelessWidget {
  final String text;
  List<String> splittedworkouts = [];

  CustomWorkoutText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    splittedworkouts = text.toString().split(" ");
    // get type of workout

    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(3),
          elevation: 1,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: FitnessAppTheme.nearlyWhite, width: 1)),
          child: ListTile(
            title: Text(splittedworkouts[0]),
            subtitle: Text(splittedworkouts[1] +
                " kCal" +
                ", " +
                splittedworkouts[2] +
                " min"),
          ),
        ),
      ],
    );
  }
}
