import 'package:flutter/material.dart';
import 'package:number_slide_animation/number_slide_animation.dart';

class BurnedIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * 0.5,
              width: constraints.maxWidth * 0.5,
              //color: Colors.blue,
              child: FittedBox(
                child: Text("Burned", style: indicator,),
                fit: BoxFit.fill,
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  height: constraints.maxHeight * 0.5,
                  width: constraints.maxWidth * 0.2,
                  //color: Colors.red,
                  child: FittedBox(
                    child: Image.asset("assets/home_screen/Fire.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.5,
                  width: constraints.maxWidth * 0.5,
                  padding: EdgeInsets.fromLTRB(10, 0, 6, 0),
                  //color: Colors.red,
                  child: FittedBox(
                    child: NumberSlideAnimation(
                      number: '250',
                      duration: const Duration(milliseconds: 2000),
                      textStyle: indicator2,
                      curve: Curves.linear,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.4,
                  width: constraints.maxWidth * 0.3,
                  // color: Colors.blue,
                  child: FittedBox(
                    child: Text("kCal", style: indicator3,),
                    fit: BoxFit.fitHeight,
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
