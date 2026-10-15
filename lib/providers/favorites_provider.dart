import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/modules/meal.dart';

class FavoritesProvider extends ChangeNotifier{

    final List<Meal> _favoriteMeals = [];
   List<Meal> get favoriteMeals => _favoriteMeals;
    void toggleFavorite(String mealId) {
    final existingIndex =
        favoriteMeals.indexWhere((meal) => meal.id == mealId);
    //remove meal from favoriate when  the meal is already in favoriat
    if (existingIndex >= 0) {
      // setState(() {
        favoriteMeals.removeAt(existingIndex);
        // notifyListeners();
      // });
    } else {
      // setState(() {
        favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
        // notifyListeners();
      // });
    }
    notifyListeners();
  }

//to see if this meal is already in favoriate meal or not,replace the star icon
  bool isMealFavorite(String id) {
    return favoriteMeals.any((meal) => meal.id == id);
  }

}