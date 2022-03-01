import 'package:profit/models/post_food_data_model.dart';
import 'package:profit/services/foodServices/post_food_service.dart';

class FoodRepository {
  final FoodWebServices foodWebServices;

  FoodRepository(this.foodWebServices);

  Future<CalculatedItems> getAllCalculatedFood(
      num quantity, String foodId) async {
    final fooditems = foodWebServices.getCalculatedItem(quantity, foodId);

    print(fooditems);
    return fooditems;
  }
}
