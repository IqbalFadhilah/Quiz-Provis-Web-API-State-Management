// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:quiz_flutter_web_api/model/food.dart';

// class FoodProvider {
//   final String baseUrl;

//   FoodProvider({required this.baseUrl});

//   Future<List<Food>> fetchMenu() async {
//     final response = await http.get(Uri.parse('$baseUrl/read_items/items'));

//     if (response.statusCode == 200) {
//       List<dynamic> data = json.decode(response.body)['items'];
//       return data.map((item) => Food.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to load menu');
//     }
//   }
// }
