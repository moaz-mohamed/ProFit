import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profit/bloc/postapi/post_food_item_bloc.dart';
import 'package:profit/bloc/postapi/post_food_item_event.dart';
import 'package:profit/bloc/postapi/post_food_item_state.dart';
import 'package:profit/widgets/FoodAPI/fonts.dart';

class AddFoodScreen extends StatefulWidget {
  late String foodLabel;
  late String foodID;
  CalculateFoodBloc calculateFoodBloc;

  List<String> nutrients = [
    "Calories",
    "Carbs",
    "Fibers",
    "Sugars",
    "Cholesterol",
    "Fats",
    "Sat Fats",
    "Trans Fats",
    "Mono Fats",
    "Poly Fats",
    "Protein",
    "Sodium",
    "Magnesium",
    "Potassium",
    "Iron",
    "Water",
  ];

  AddFoodScreen(
      {required this.calculateFoodBloc,
      required this.foodLabel,
      required this.foodID});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  late num foodQuantity;
  late double totalCalories;
  late double carbs;
  late double protein;
  late double fats;

  void initState() {
    super.initState();
    foodQuantity = 0;
    totalCalories = 0;
    carbs = 0;
    protein = 0;
    fats = 0;
    widget.calculateFoodBloc.add(
      calculateItemsEvent(
        quantity: 0,
        foodId: widget.foodID,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          "Add Food",
          style: fonts.AppBar1,
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            pinned: true,
            title: Text(
              widget.foodLabel,
              style: fonts.silverAppBar1,
            ),
          ),
          // BlocBuilder<CalculateFoodBloc, FoodItemState>(
          //   builder: (context, state) {
          //     if (state is FoodItemLoading) {
          //       return const CircularProgressIndicator();
          //     } else if (state is FoodItemLoaded) {
          //     } else if (state is FoodItemError) {
          //       return Text(state.message);
          //     }
          //     return const CircularProgressIndicator();
          //   },
          // ),
          SliverAppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Total Calories",
                    style: fonts.totalCaloriesTitle,
                  ),
                  BlocBuilder<CalculateFoodBloc, FoodItemState>(
                    builder: (context, state) {
                      if (state is FoodItemLoading) {
                        return Text(
                          "",
                          style: fonts.totalCaloriesNumber,
                        );
                      } else if (state is FoodItemLoaded) {
                        totalCalories =
                            double.parse(state.items.calories.toString());
                        return Text(
                          state.items.calories.toString(),
                          style: fonts.totalCaloriesNumber,
                        );
                      } else if (state is FoodItemError) {
                        return Text(state.message);
                      }
                      return Text(
                        "",
                        style: fonts.totalCaloriesNumber,
                      );
                    },
                  ),
                  Text(
                    "KCal",
                    style: fonts.totalCaloriesUnit,
                  ),
                ],
              ),
              background: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 0.5),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: Text(
                      "Quantity",
                      style: fonts.quantityText,
                    ),
                  ),
                  Container(
                    //color: Colors.yellow,
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.topCenter,
                    child: TextField(
                      maxLines: 1,
                      showCursor: true,
                      keyboardType: TextInputType.number,
                      style: fonts.textFieldText,
                      decoration: InputDecoration(
                        icon: Image.asset(
                          "assets/add_food_screen/scale.png",
                          scale: 2.5,
                        ),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8),
                        hintText: "Enter quantity in grams",
                        hintStyle: fonts.textFieldHint,
                      ),
                      onChanged: (String value) {
                        if (value == "") {
                          value = "0";
                        }
                        setState(() {
                          foodQuantity = num.parse(value);
                        });
                        widget.calculateFoodBloc.add(
                          calculateItemsEvent(
                            quantity: foodQuantity,
                            foodId: widget.foodID,
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: Text(
                      "Nutrition Facts",
                      style: fonts.nutritionFactsText,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: [
                                Image.asset(
                                  "assets/add_food_screen/carbs.png",
                                  scale: 3,
                                ),
                                Text(
                                  " Carbs",
                                  style: fonts.nutrientsText,
                                ),
                              ],
                            ),
                            BlocBuilder<CalculateFoodBloc, FoodItemState>(
                              builder: (context, state) {
                                if (state is FoodItemLoading) {
                                  return Text(
                                    "",
                                    style: fonts.nutrientsValue,
                                  );
                                } else if (state is FoodItemLoaded) {
                                  carbs = double.parse(state
                                      .items
                                      .totalNutrients!
                                      .nutrientsValuesMap["Carbs"]);
                                  return Text(
                                    "${state.items.totalNutrients!.nutrientsValuesMap["Carbs"]} gm",
                                    style: fonts.nutrientsValue,
                                  );
                                } else if (state is FoodItemError) {
                                  return Text(state.message);
                                }
                                return Text(
                                  "",
                                  style: fonts.nutrientsValue,
                                );
                              },
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: [
                                Image.asset(
                                  "assets/add_food_screen/protein.png",
                                  scale: 3,
                                ),
                                Text(
                                  " Protein",
                                  style: fonts.nutrientsText,
                                ),
                              ],
                            ),
                            BlocBuilder<CalculateFoodBloc, FoodItemState>(
                              builder: (context, state) {
                                if (state is FoodItemLoading) {
                                  return Text(
                                    "",
                                    style: fonts.nutrientsValue,
                                  );
                                } else if (state is FoodItemLoaded) {
                                  protein = double.parse(state
                                      .items
                                      .totalNutrients
                                      ?.nutrientsValuesMap["Protein"]);
                                  return Text(
                                    "${state.items.totalNutrients?.nutrientsValuesMap["Protein"]} gm",
                                    style: fonts.nutrientsValue,
                                  );
                                } else if (state is FoodItemError) {
                                  return Text(state.message);
                                }
                                return Text(
                                  "",
                                  style: fonts.nutrientsValue,
                                );
                              },
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              children: [
                                Image.asset(
                                  "assets/add_food_screen/fats.png",
                                  scale: 3,
                                ),
                                Text(
                                  " Fats",
                                  style: fonts.nutrientsText,
                                ),
                              ],
                            ),
                            BlocBuilder<CalculateFoodBloc, FoodItemState>(
                              builder: (context, state) {
                                if (state is FoodItemLoading) {
                                  return Text(
                                    "",
                                    style: fonts.nutrientsValue,
                                  );
                                } else if (state is FoodItemLoaded) {
                                  fats = double.parse(state.items.totalNutrients
                                      ?.nutrientsValuesMap["Fats"]);
                                  return Text(
                                    "${state.items.totalNutrients?.nutrientsValuesMap["Fats"]} gm",
                                    style: fonts.nutrientsValue,
                                  );
                                } else if (state is FoodItemError) {
                                  return Text(state.message);
                                }
                                return Text(
                                  "",
                                  style: fonts.nutrientsValue,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.fromLTRB(26, 0, 26, 0),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.nutrients[index],
                        style: fonts.nutrientsList,
                      ),
                      BlocBuilder<CalculateFoodBloc, FoodItemState>(
                        builder: (context, state) {
                          if (state is FoodItemLoading) {
                            return Text(
                              "",
                              style: fonts.nutrientsListValue,
                            );
                          } else if (state is FoodItemLoaded) {
                            return Text(
                              "${state.items.totalNutrients!.nutrientsValuesMap.values.toList()[index]}",
                              style: fonts.nutrientsListValue,
                            );
                          } else if (state is FoodItemError) {
                            return Text(state.message);
                          }
                          return Text(
                            "",
                            style: fonts.nutrientsListValue,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
              childCount: widget.nutrients.length,
            ),
          ),
        ],
      ),
      //////------>>>>>> Add food button
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: Icon(Icons.ac_unit),
          // Checked and working
          onPressed: () {
            print("$totalCalories");
            print("$carbs");
            print("$protein");
            print("$fats");
          },
        ),
      ),
    );
  }
}
