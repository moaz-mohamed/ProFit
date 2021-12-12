import 'package:profit/models/food_item.dart';
import 'package:profit/services/edamam_service.dart';

class FoodRepository {
  final FoodWebServices foodWebServices;

  FoodRepository(this.foodWebServices);

  Future<Items> getAllFood(String food) async {
    final fooditems = foodWebServices.getItem(food);
    // print(fooditems);
    return fooditems;
  }
}
