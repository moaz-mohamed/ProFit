import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:profit/bloc/food/food_item_bloc.dart';
import 'package:profit/bloc/food/food_item_event.dart';
import 'package:profit/bloc/search/search_bloc.dart';
import 'package:profit/bloc/search/search_event.dart';
import 'package:profit/bloc/search/search_state.dart';
import 'package:profit/models/food_data.dart';
import 'package:profit/repositories/search_repo.dart';
import 'package:profit/services/search_service.dart';

main() {
  runApp(const FoodScreen());
}

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  late Items items;
  List<Hints> AllHintsItems = [];
  late List<Hints> searchedHintsItems;
  bool _isSearching = false;

  final _searchTextController = TextEditingController();
  late FoodBloc foodBloc;
  @override
  void initState() {
    foodBloc = BlocProvider.of<FoodBloc>(context);
    foodBloc.add(FetchItems(food: 'egg'));
    //searchFoodBloc.add(TextChanged(query: ))
    super.initState();
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            // Navigator.pop(context);
          },
          icon: const Icon(Icons.clear, color: Colors.amber),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: const Icon(
            Icons.search,
            color: Colors.amber,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Search'),
              backgroundColor: Colors.blueAccent,
              actions: [
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: FoodSearch(
                              searchBloc:
                                  BlocProvider.of<SearchBloc>(context)));
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
      },
    );
  }
}

class FoodSearch extends SearchDelegate<List?> {
  late Items items;
  List<Hints> AllHintsItems = [];
  late List<Hints> searchedHintsItems;
  bool _isSearching = false;
  SearchBloc searchBloc;
  FoodSearch({required this.searchBloc});
  late String queryString;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
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
    queryString = query;

    return BlocProvider(
      create: (context) => SearchBloc(SearchRepository(SearchWebServices()))
        ..add(Search(query: query)),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (BuildContext context, SearchState state) {
          if (state is SearchLoaded) {
            print("SearchLoaded");
            items = (state).recipes;
            AllHintsItems = items.hints;
            print("hjkhkjhjhakhkahskahkas");
            print(AllHintsItems[4]);
            if (state.recipes.hints.isEmpty) {
              return const Center(
                child: Text('No Results'),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  child: InkWell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.recipes.hints[index].food.label),
                      ],
                    ),
                  ),
                );

                //Text(state.recipes[index].title);
              },
              itemCount: AllHintsItems.length,
            );
          } else if (state is SearchInitial) {
            print("SearchUninitialized");
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchError) {
            return const Center(
              child: Text('Failed To Load'),
            );
          }
          ;

          return Scaffold();
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class FoodDetail extends StatelessWidget {
  final Food recipes;
  const FoodDetail({required this.recipes});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipes.label),
      ),
      body: Column(
        children: [
          Text(recipes.label),
        ],
      ),
    );
  }
}
// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('All Foods'),
//       ),
//       body: Center(
//         child: BlocBuilder<FoodBloc, FoodItemState>(
//           builder: (context, state) {
//             if (state is FoodItemLoading) {
//               return const CircularProgressIndicator();
//             } else if (state is FoodItemLoaded) {
//               return Column(
//                 children: <Widget>[
//                   // buildSeacrh(),
//                   Expanded(
//                       child: ListView.builder(
//                           itemCount: state.items.hints.length,
//                           itemBuilder: (context, i) {
//                             return Card(
//                               margin: const EdgeInsets.all(10.0),
//                               child: ListTile(
//                                 title: Text(state.items.hints[i].food.label),
//                                 subtitle: Text(state
//                                     .items.hints[i].food.nutrients.ENERCKCAL
//                                     .toString()),
//                               ),
//                             );
//                           }))
//                 ],
//               );
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
