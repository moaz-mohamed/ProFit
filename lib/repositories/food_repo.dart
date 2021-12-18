import 'package:profit/models/food_data.dart';
import 'package:profit/services/food_service.dart';

class FoodRepository {
  final FoodWebServices foodWebServices;

  FoodRepository(this.foodWebServices);

  Future<Items> searchFoods(String food) async {
    final fooditems = foodWebServices.getItem(food);
    return fooditems;
  }
}
