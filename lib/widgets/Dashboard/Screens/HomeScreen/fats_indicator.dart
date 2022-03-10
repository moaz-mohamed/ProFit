import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:number_slide_animation/number_slide_animation.dart';

class FatsIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * 0.4,
                  width: constraints.maxWidth * 0.2,
                  child: FittedBox(
                    child: Image.asset("assets/home_screen/Fats.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.4,
                  width: constraints.maxWidth * 0.5,
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: FittedBox(
                    child: Text(
                      "Fats",
                      style: indicator,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            Container(
              height: constraints.maxHeight * 0.2,
              width: constraints.maxWidth,
              //color: Colors.blue,
              child: LinearPercentIndicator(
                percent: 0.8,
                width: constraints.maxWidth,
                lineHeight: constraints.maxHeight * 0.1,
                backgroundColor: Colors.black26,
                animation: true,
                animationDuration: 2000,
                linearGradient: LinearGradient(colors: <Color>[
                  Colors.yellow.withOpacity(0.1),
                  Colors.yellow.withOpacity(0.2),
                  Colors.yellow.withOpacity(0.3),
                  Colors.yellow.withOpacity(0.4),
                  Colors.yellow.withOpacity(0.5),
                  Colors.yellow.withOpacity(0.6),
                  Colors.yellow.withOpacity(0.7),
                  Colors.yellow.withOpacity(0.8),
                  Colors.yellow.withOpacity(0.9),
                  Colors.yellow.withOpacity(1),
                ]),
                clipLinearGradient: true,
                linearStrokeCap: LinearStrokeCap.roundAll,
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * 0.4,
                  width: constraints.maxWidth * 0.3,
                  padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                  child: FittedBox(
                    child: NumberSlideAnimation(
                      number: '10',
                      duration: const Duration(milliseconds: 2000),
                      textStyle: indicator2,
                      curve: Curves.linear,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.4,
                  width: constraints.maxWidth * 0.66,
                  // color: Colors.blue,
                  child: FittedBox(
                    child: Text(
                      "Grams left",
                      style: indicator3,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  static const TextStyle indicator = TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.black,
  );

  static const TextStyle indicator2 = TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.blue,
  );

  static const TextStyle indicator3 = TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.black45,
  );
}
