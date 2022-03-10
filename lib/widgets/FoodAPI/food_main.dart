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

class FoodMain extends StatelessWidget {
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
          home: FoodScreen(),
        ),
    );
  }
}
