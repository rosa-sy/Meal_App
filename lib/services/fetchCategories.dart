import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meal_app/modules/meal_category.dart';

Future<List<MealCategory>> fetchCategories() async {
  final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<dynamic>categoryList=data['categories'] ;
    final categories = categoryList.map((item) => MealCategory.fromJson(item)).toList();
    // final categories = (data['categories'] as List)
    //     .map((item) => MealCategory.fromJson(item))
    //     .toList();
    return categories;
  } else {
    throw Exception('Failed to fetch categories');
  }
}