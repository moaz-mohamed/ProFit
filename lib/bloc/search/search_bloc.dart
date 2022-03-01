import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:profit/bloc/search/search_event.dart';
import 'package:profit/bloc/search/search_state.dart';
import 'package:profit/repositories/foodRepositories/search_repo.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository searchRepository;

  SearchBloc(this.searchRepository) : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is Search) {
      yield SearchLoading();
      try {
        final recipes = await searchRepository.searchFoods(event.query);
        yield SearchLoaded(recipes);
      } catch (e) {
        yield SearchError(e.toString());
      }
    }
  }
}

/*
class FoodBloc extends Bloc<FoodItemEvent, FoodItemState> {
  final FoodRepository repository;

  FoodBloc(this.repository) : super(FoodItemInitial());

  String foodToSearch;

  @override
  Stream<FoodItemState> mapEventToState(
    FoodItemEvent event,
  ) async* {
    if (event is FoodItemEvent) {
      yield FoodItemLoading();
      try {
        final items = await repository.searchFoods('rice');
        yield FoodItemLoaded(items);
      } catch (e) {
        yield FoodItemError(e.toString());
      }
    }
  }
}
*/


//final recipes = await searchRepository.searchFoods(event.query);