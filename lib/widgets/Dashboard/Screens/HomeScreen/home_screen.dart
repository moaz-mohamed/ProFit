import 'package:profit/widgets/Dashboard/Screens/HomeScreen/calories_indicator.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/eaten_indicator.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/burned_indicator.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/carbs_indicator.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/first_dashboard.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/protein_indicator.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/fats_indicator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          // color: Colors.black12,
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
          //   boxShadow: [
          //     BoxShadow(
          //       spreadRadius: 6,
          //       blurRadius: 10,
          //     ),
          //   ],
          // ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ///--->>> Upper container
                  Container(
                    height: constraints.maxHeight * 0.6,
                    width: constraints.maxWidth,
                    // color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ///--->>> Right container
                        Container(
                          height: constraints.maxHeight * 0.6,
                          width: constraints.maxWidth * 0.4,
                          // color: Colors.green,
                          child: CaloriesIndicator(),
                        ),

                        ///--->>> Left container
                        Container(
                          height: constraints.maxHeight * 0.6,
                          width: constraints.maxWidth * 0.5,
                          // color: Colors.blue,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: constraints.maxHeight * 0.3,
                                width: constraints.maxWidth * 0.4,
                                child: EatenIndicator(),
                              ),
                              Container(
                                height: constraints.maxHeight * 0.3,
                                width: constraints.maxWidth * 0.4,
                                child: BurnedIndicator(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Lower container
                  Container(
                    height: constraints.maxHeight * 0.3,
                    width: constraints.maxWidth,
                    // color: Colors.yellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: constraints.maxHeight * 0.3,
                          width: constraints.maxWidth * 0.3,
                          // color: Colors.red,
                          child: CarbsIndicator(),
                        ),
                        Container(
                          height: constraints.maxHeight * 0.3,
                          width: constraints.maxWidth * 0.3,
                          // color: Colors.green,
                          child: ProteinIndicator(),
                        ),
                        Container(
                          height: constraints.maxHeight * 0.3,
                          width: constraints.maxWidth * 0.3,
                          // color: Colors.blue,
                          child: FatsIndicator(),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        ///--->>> Meals buttons
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          child: Dashboard(),

          ///--->>> Fangary's widget goes in here as a scrollable list under the indicators

          ///
        ),
        // Container(
        //   child: ElevatedButton(
        //     child: Icon(Icons.ac_unit),
        //     onPressed: () {
        //       Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => FoodMain(),
        //           ),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
