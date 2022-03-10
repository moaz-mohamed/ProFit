import 'package:profit/widgets/Dashboard/Screens/HomeScreen/calories_indicator.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/eaten_indicator.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/burned_indicator.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/carbs_indicator.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/protein_indicator.dart';
import 'package:profit/widgets/Dashboard/Screens/HomeScreen/fats_indicator.dart';
import 'package:profit/widgets/FoodAPI/food_main.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("ProFit"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              //borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  color: Colors.lightBlue,
                  spreadRadius: 6,
                  blurRadius: 10,
                ),
              ],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: <Widget>[
                    // Upper container
                    Container(
                      height: constraints.maxHeight * 0.7,
                      width: constraints.maxWidth,
                      child: Row(
                        children: <Widget>[
                          // Left container
                          Container(
                            height: constraints.maxHeight * 0.7,
                            width: constraints.maxWidth * 0.5,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: constraints.maxHeight * 0.35,
                                  width: constraints.maxWidth * 0.5,
                                  padding: EdgeInsets.all(6),
                                  child: EatenIndicator(),
                                ),
                                Container(
                                  height: constraints.maxHeight * 0.35,
                                  width: constraints.maxWidth * 0.5,
                                  padding: EdgeInsets.all(6),
                                  child: BurnedIndicator(),
                                ),
                              ],
                            ),
                          ),
                          // Right container
                          Container(
                            height: constraints.maxHeight * 0.7,
                            width: constraints.maxWidth * 0.5,
                            child: CaloriesIndicator(),
                          ),
                        ],
                      ),
                    ),
                    // Lower container
                    Container(
                      height: constraints.maxHeight * 0.3,
                      width: constraints.maxWidth,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: constraints.maxHeight * 0.3,
                            width: constraints.maxWidth / 3,
                            padding: EdgeInsets.all(6),
                            child: CarbsIndicator(),
                          ),
                          Container(
                            height: constraints.maxHeight * 0.3,
                            width: constraints.maxWidth / 3,
                            padding: EdgeInsets.all(6),
                            child: ProteinIndicator(),
                          ),
                          Container(
                            height: constraints.maxHeight * 0.3,
                            width: constraints.maxWidth / 3,
                            padding: EdgeInsets.all(6),
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
          Container(
            child: ElevatedButton(
              child: Icon(Icons.ac_unit),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FoodMain(),
                    ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
