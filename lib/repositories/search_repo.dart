import 'package:profit/models/food_data.dart';
import 'package:profit/services/search_service.dart';

class SearchRepository {
  final SearchWebServices searchWebServices;

  SearchRepository(this.searchWebServices);

  Future<Items> searchFoods(String food) async {
    final fooditems = searchWebServices.searchItem(food);

    return fooditems;
  }
}
