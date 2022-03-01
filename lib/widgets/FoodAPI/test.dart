// import 'dart:convert';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:profit/bloc/postapi/post_food_item_bloc.dart';
// import 'package:profit/repos/food_repo.dart';
// import 'package:profit/services/post_food_service.dart';
// import 'bloc/postapi/post_food_item_state.dart';
// import 'bloc/postapi/post_food_item_event.dart';

// class test extends StatelessWidget{

//   CalculateFoodBloc calculateFoodBloc;

//   test({required this.calculateFoodBloc});

//   @override
//   Widget build(BuildContext context) {
//     calculateFoodBloc.add(calculateItemsEvent(quantity: 200, foodId: "food_bmyxrshbfao9s1amjrvhoauob6mo"));
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('All Foods'),
//       ),
//       body: Center(
//         child: BlocBuilder<CalculateFoodBloc, FoodItemState>(
//           builder: (context, state) {
//             if (state is FoodItemLoading) {
//               return const CircularProgressIndicator();
//             } else if (state is FoodItemLoaded) {
//               return ListView.builder(
//                   itemCount: 1,
//                   itemBuilder: (context, i) {
//                     return Card(
//                       margin: const EdgeInsets.all(10.0),
//                       child: ListTile(
//                           title: Text(state.items.calories.toString()),
//                           subtitle: Text(state
//                               .items.totalNutrients!.water!.quantity
//                               .toString())),
//                     );
//                   });
//             } else if (state is FoodItemError) {
//               return Text(state.message);
//             }
//             return const CircularProgressIndicator();
//           },
//         ),
//       ),
//     );
//   }

// }