import 'package:profit/models/food_data_model.dart';
import 'package:profit/services/foodServices/search_service.dart';

class SearchRepository {
  final SearchWebServices searchWebServices;

  SearchRepository(this.searchWebServices);

  Future<Items> searchFoods(String food) async {
    final fooditems = searchWebServices.searchItem(food);

    return fooditems;
  }
}
