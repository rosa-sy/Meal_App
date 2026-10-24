import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meal_app/modules/search_meal.dart';

Future<List<SearchMeal>> fetchSearchMeals(String query) async {
  try {final response = await http.get(
    Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$query'),
   
  ).timeout(const Duration(seconds: 10), onTimeout: () {
    throw Exception('انتهت مهلة الاتصال');
  });

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<dynamic>? mealsList = data['meals'];

    if (mealsList == null) {
      return [];  
    }

    return mealsList.map((json) => SearchMeal.fromJson(json)).toList();
  } else {
    throw Exception('فشل البحث');
  }
} catch (e) {
  print(e);
    throw Exception('Could not load results. Check your connection and try again.');
  }}