import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:number_slide_animation/number_slide_animation.dart';

class CaloriesIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CircularPercentIndicator(
          radius: constraints.maxHeight * 0.8,
          percent: 0.8,
          backgroundWidth: 6,
          lineWidth: 16,
          animation: true,
          animationDuration: 2000,
          backgroundColor: Colors.black26,
          linearGradient: LinearGradient(colors: <Color>[
            Colors.red.withOpacity(0.1),
            Colors.red.withOpacity(0.2),
            Colors.red.withOpacity(0.3),
            Colors.red.withOpacity(0.4),
            Colors.red.withOpacity(0.5),
            Colors.blue.withOpacity(0.6),
            Colors.blue.withOpacity(0.7),
            Colors.blue.withOpacity(0.8),
            Colors.blue.withOpacity(0.9),
            Colors.blue.withOpacity(1),
          ]),
          rotateLinearGradient: true,
          circularStrokeCap: CircularStrokeCap.round,
          widgetIndicator: Image.asset(
            "assets/home_screen/Plate.png",
            scale: 2.5,
          ),
          center: Container(
            height: constraints.maxHeight * 0.4,
            //color: Colors.red,
            child: Column(
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * 0.25,
                  width: constraints.maxWidth * 0.3,
                  child: FittedBox(
                    child: NumberSlideAnimation(
                      number: '1275',
                      duration: const Duration(milliseconds: 2000),
                      textStyle: indicator1,
                      curve: Curves.linear,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.15,
                  width: constraints.maxWidth * 0.35,
                  child: FittedBox(
                    child: Text("kCal Left", style: indicator2,),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static const TextStyle indicator1 = TextStyle(
    fontWeight: FontWeight.w900,
    color: Colors.blue,
  );

  static const TextStyle indicator2 = TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.black45,
  );
}
