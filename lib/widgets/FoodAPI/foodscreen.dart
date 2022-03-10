import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:profit/bloc/barcode/bar_item_bloc.dart';
import 'package:profit/bloc/barcode/bar_item_event.dart';
import 'package:profit/bloc/barcode/bar_item_state.dart';
import 'package:profit/bloc/postapi/post_food_item_bloc.dart';
import 'package:profit/bloc/search/search_bloc.dart';
import 'package:profit/bloc/search/search_event.dart';
import 'package:profit/bloc/search/search_state.dart';
import 'package:profit/models/food_data_model.dart';
import 'package:profit/widgets/FoodAPI/AddFoodScreen.dart';
import 'package:profit/widgets/FoodAPI/bar_code_widget.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext foodScreenContext) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          backgroundColor: Colors.blueAccent,
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: foodScreenContext,
                    delegate: FoodSearch(
                      searchBloc: BlocProvider.of<SearchBloc>(context),
                    ),
                  );
                }),
            IconButton(
                icon: Icon(Icons.qr_code_scanner),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BarCodeSearch(
                        barcodebloc: BlocProvider.of<BarCodeBloc>(context),
                      ),
                    ),
                  );
                }),
          ],
        ),
        body: const Center(
          child: Text(
            "No Food found",
            style: TextStyle(color: Colors.black, fontSize: 28.0),
            textAlign: TextAlign.center,
          ),
        ));
  }
}

class FoodSearch extends SearchDelegate<List?> {
  late Items items;
  List<Hints> allHintsItems = [];
  late String queryString;
  late String foodId = '';
  late String measureUri = '';

  SearchBloc searchBloc;

  FoodSearch({required this.searchBloc});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    searchBloc.add(Search(query: query));
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, SearchState state) {
        if (state is SearchLoaded) {
          items = (state).recipes;
          allHintsItems = items.hints;
          if (items.parsed.isEmpty) {
            return const Center(
              child: Text('There is no food item with this name'),
            );
          } else {
            foodId = items.parsed[0].food!.foodId;
            measureUri = items.hints[0].measures[0].uri;
            print(foodId + '' + measureUri);

            if (state.recipes.hints.isEmpty) {
              return const Center(
                child: Text('No Results'),
              );
            } else {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: const EdgeInsets.all(20.0),
                    child: InkWell(
                      child: ListTile(
                        leading: const Icon(Icons.food_bank_outlined),
                        title: Text(
                          state.recipes.hints[index].food.label,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                        subtitle: Text(state
                            .recipes.hints[index].food.nutrients.ENERCKCAL
                            .toString()),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddFoodScreen(
                                calculateFoodBloc:
                                    BlocProvider.of<CalculateFoodBloc>(context),
                                foodLabel: items.hints[index].food.label,
                                foodID: items.hints[index].food.foodId,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
                itemCount: allHintsItems.length,
              );
            }
          }
        } else if (state is SearchInitial) {
          print('Initial state is yielded');
          return const Center(child: CircularProgressIndicator());
        } else {
          print('Seach error state is yielded');
          return const Center(child: CircularProgressIndicator());
        }

        //updating the last conditional
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
