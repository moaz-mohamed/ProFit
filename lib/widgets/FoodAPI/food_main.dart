import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profit/bloc/barcode/bar_item_bloc.dart';
import 'package:profit/bloc/postapi/post_food_item_bloc.dart';
import 'package:profit/bloc/search/search_bloc.dart';
import 'package:profit/repositories/foodRepositories/barcode_repo.dart';
import 'package:profit/repositories/foodRepositories/food_repo.dart';
import 'package:profit/repositories/foodRepositories/search_repo.dart';
import 'package:profit/services/foodServices/barcode_service.dart';
import 'package:profit/services/foodServices/post_food_service.dart';
import 'package:profit/services/foodServices/search_service.dart';
import 'package:profit/widgets/FoodAPI/foodscreen.dart';

<<<<<<< HEAD:lib/widgets/FoodAPI/main.dart
enum FoodType { breakfast, lunch, dinner }


class MyApp extends StatelessWidget {
=======
class FoodMain extends StatelessWidget {
>>>>>>> 0cae8c20ba45582d83a27bd840fa011c63b0b1dc:lib/widgets/FoodAPI/food_main.dart
  // This widget is the root of your application.
  @override
  // ignore: avoid_renaming_method_parameters
  Widget build(BuildContext myAppContext) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (searchBloccontext) =>
                SearchBloc(SearchRepository(SearchWebServices())),
          ),
          BlocProvider(
            create: (barBloccontext) =>
                BarCodeBloc(BarCodeRepository(BarCodeServices())),
          ),
          BlocProvider(
            create: (calculateBlocContext) =>
                CalculateFoodBloc(FoodRepository(FoodWebServices())),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Foodie App',
<<<<<<< HEAD:lib/widgets/FoodAPI/main.dart
          home:
              FoodScreen(foodtype: 1), //1 here means index of second enum lunch
        ));
=======
          home: FoodScreen(),
        ),
    );
>>>>>>> 0cae8c20ba45582d83a27bd840fa011c63b0b1dc:lib/widgets/FoodAPI/food_main.dart
  }
}
