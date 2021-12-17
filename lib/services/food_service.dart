import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:profit/models/food_data.dart';

final baseApi =
    'https://api.edamam.com/api/food-database/v2/parser?app_id=923b5c56&app_key=8f43167e9a47f5f2e89b037655a08552';
//but without the food to search

class FoodWebServices {
  Future<Items> getItem(String food) async {
    String api = baseApi + '&ingr=$food';
    http.Response itemResponse = await http.get(Uri.parse(api));
    if (itemResponse.statusCode == 200) {
      return Items.fromJson(json.decode(itemResponse.body));
    } else {
      throw Exception('Cant retrieve this item');
    }
  }
}
