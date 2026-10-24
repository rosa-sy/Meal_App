import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/modules/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier{

FavoritesProvider() {
  _loadFavorites();
}
Future<void> _loadFavorites() async {
final ref=await SharedPreferences.getInstance();

final ids = ref.getStringList('favorites') ?? [];

_favoriteMeals.addAll(DUMMY_MEALS.where((meal) => ids.contains(meal.id)).toList());

notifyListeners();

}

Future <void> _saveFavorites() async {
final ref=await SharedPreferences.getInstance();
await ref.setStringList('favorites', _favoriteMeals.map((meal) => meal.id).toList());
}


    final List<Meal> _favoriteMeals = [];
   List<Meal> get favoriteMeals => _favoriteMeals;
    void toggleFavorite(String mealId) {
    final existingIndex =
        favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
     
        favoriteMeals.removeAt(existingIndex);
       
    } else {
    
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
       
    }
    notifyListeners();
    _saveFavorites();
  }


  bool isMealFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }

}