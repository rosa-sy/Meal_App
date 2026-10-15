import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meal_app/providers/favorites_provider.dart';

// import '../modules/meal.dart';
import '../widgt/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    
    
      return Consumer<FavoritesProvider>(
        builder: (context, favorites, child) {
          final favoriatMeals = favorites.favoriteMeals;
          // final favoriatMeals = context.watch<FavoritesProvider>().favoriteMeals;
          if (favoriatMeals.isEmpty) {
          return const Center(
              child: Text("you have no favorites yet - start adding some!"));
        }else {
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
      );
   
  }
}
