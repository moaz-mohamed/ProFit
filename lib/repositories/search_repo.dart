import 'package:profit/models/food_data.dart';
import 'package:profit/services/search_service.dart';

class SearchRepository {
  final SearchWebServices searchWebServices;

  SearchRepository(this.searchWebServices);

  Future<Items> searchFoods(String food) async {
    print("object");
    final fooditems = searchWebServices.searchItem(food);
    print(food);
    print("object2");
    return fooditems;
  }
}
