import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/modules/meal.dart';
import 'package:meal_app/widgt/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = "category_meals";
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayMeals;

  void _removeMeal(String mealId) {
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final categoryId = routeArg['id'];
    categoryTitle = routeArg['title']!;
    displayMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  @override
  void initStat() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayMeals[index].id,
            imageUrl: displayMeals[index].imageUrl,
            title: displayMeals[index].title,
            affordability: displayMeals[index].affordability,
            complexity: displayMeals[index].complexity,
            duration: displayMeals[index].duration,
            // removeItem: _removeMeal,
          );
        },
        itemCount: displayMeals.length,
      ),
    );
  }
}
