import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profit/bloc/search/search_event.dart';
import 'package:profit/bloc/search/search_state.dart';
import 'package:profit/repositories/search_repo.dart';

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
