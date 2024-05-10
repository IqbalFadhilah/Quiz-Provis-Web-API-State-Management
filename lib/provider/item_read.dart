import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/food.dart';

Future<List<FoodItem>> fetchFoodItemsFromAPI() async {
  final response = await http.get(Uri.parse('http://146.190.109.66:8000/items/'));

  if (response.statusCode == 200) {
    // Jika permintaan berhasil, parse response JSON
    List<dynamic> data = json.decode(response.body);
    List<FoodItem> foodItems = data.map((json) => FoodItem.fromJson(json)).toList();
    return foodItems;
  } else {
    // Jika permintaan gagal, throw Exception
    throw Exception('Failed to load food items from API');
  }
}
