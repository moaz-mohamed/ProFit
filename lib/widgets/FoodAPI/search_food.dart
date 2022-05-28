import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:profit/bloc/postapi/post_food_item_bloc.dart';
import 'package:profit/bloc/search/search_bloc.dart';
import 'package:profit/bloc/search/search_event.dart';
import 'package:profit/bloc/search/search_state.dart';
import 'package:profit/models/food_data_model.dart';

import 'AddFoodScreen.dart';

class FoodSearch extends SearchDelegate<List?> {
  late Items items;
  List<Hints> allHintsItems = [];
  late String queryString;
  late String foodId = '';
  late String measureUri = '';

  SearchBloc searchBloc;
  int foodtype; //type of food from the enum

  FoodSearch({required this.searchBloc, required this.foodtype});

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

            if (state.recipes.hints.isEmpty) {
              return const Center(
                child: Text('No Results'),
              );
            } else {
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.blueGrey.shade100, width: 4),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        child: ListTile(
                          leading: Image.asset(
                            'assets/Food/food.png',
                          ),
                          title: Text(state.recipes.hints[index].food.label,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "SourceSansPro",
                                  fontSize: 20.0,
                                  color: Colors.blue)),
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
                                        BlocProvider.of<CalculateFoodBloc>(
                                            context),
                                    foodLabel: items.hints[index].food.label,
                                    foodID: items.hints[index].food.foodId,
                                    foodtype: foodtype),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                itemCount: allHintsItems.length,
              );
            }
          }
        } else if (state is SearchInitial) {
          //print('Initial state is yielded');
          return loadingindicator();
        } else {
          //print('Seach error state is yielded');
          return loadingindicator();
        }

        //updating the last conditional
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  loadingindicator() {
    return const Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: LoadingIndicator(
          indicatorType: Indicator.ballClipRotateMultiple,
          colors: [Colors.blue],
        ),
      ),
    );
  }
}
