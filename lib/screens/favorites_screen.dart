import 'package:flutter/material.dart';

import '../modules/meal.dart';
import '../widgt/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  // const FavoritesScreen({super.key});
  final List<Meal> favoriatMeals;
  FavoritesScreen(this.favoriatMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriatMeals.isEmpty) {
      return Center(
          child: Text("you have no favorites yet - start adding some!"));
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriatMeals[index].id,
            imageUrl: favoriatMeals[index].imageUrl,
            title: favoriatMeals[index].title,
            affordability: favoriatMeals[index].affordability,
            complexity: favoriatMeals[index].complexity,
            duration: favoriatMeals[index].duration,
            // removeItem: _removeMeal,
          );
        },
        itemCount: favoriatMeals.length,
      );
    }
  }
}
