import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:profit/models/post_food_data_model.dart';

final baseApi =
    'https://api.edamam.com/api/food-database/v2/nutrients?app_id=923b5c56&app_key=8f43167e9a47f5f2e89b037655a08552';
//but without the food to search

class FoodWebServices {
  Future<CalculatedItems> getCalculatedItem(num quantity, String foodId) async {
    var url = baseApi;

    var body = json.encode({
      "ingredients": [
        {
          "quantity": quantity,
          "measureURI":
              "http://www.edamam.com/ontologies/edamam.owl#Measure_gram", //Fixed quantity of measurment
          "foodId": foodId
        }
      ]
    });

    http.Response itemResponse = await http.post(
      Uri.parse(url),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: body,
    );
    if (itemResponse.statusCode == 200) {
      return CalculatedItems.fromJson(json.decode(itemResponse.body));
    } else {
      throw Exception('Cant retrieve this food item');
    }
  }
}
