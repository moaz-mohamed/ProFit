import 'dart:convert';
import 'package:profit/models/food_item.dart';
import 'package:http/http.dart' as http;
import 'package:profit/utils/constants/constants.dart';

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
