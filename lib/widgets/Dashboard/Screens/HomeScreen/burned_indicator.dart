import 'package:flutter/material.dart';
import 'package:profit/themes/ThemeUI.dart';
import 'package:number_slide_animation/number_slide_animation.dart';

class BurnedIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/home_screen/Fire.png", scale: 2.6,),
                Text("Burned", style: FitnessAppTheme.eatenIndicatorText,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("12345", style: FitnessAppTheme.eatenIndicatorValue,),
                Text(" (kCal)", style: FitnessAppTheme.eatenIndicatorUnit,),
              ],
            )
          ],
        );
      },
    );
  }
}
