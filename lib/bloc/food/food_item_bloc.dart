import 'package:bloc/bloc.dart';
import 'package:profit/bloc/food/food_item_event.dart';
import 'package:profit/bloc/food/food_item_state.dart';
import 'package:profit/repositories/food_repo.dart';

class FoodBloc extends Bloc<FoodItemEvent, FoodItemState> {
  final FoodRepository repository;

  FoodBloc(this.repository) : super(FoodItemInitial());
  late String foodToSearch;

  @override
  Stream<FoodItemState> mapEventToState(
    FoodItemEvent event,
  ) async* {
    if (event is FetchItems) {
      yield FoodItemLoading();
      try {
        final items = await repository.searchFoods(event.food);
        yield FoodItemLoaded(items);
      } catch (e) {
        yield FoodItemError(e.toString());
      }
    }
  }
}
