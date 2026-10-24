import 'package:flutter/material.dart';

import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/screens/category_meals_screen.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/mail_detail_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

import 'modules/meal.dart';

import 'package:provider/provider.dart';
import 'package:meal_app/providers/favorites_provider.dart';

import 'screens/search_screen.dart';
// void main() => runApp(
//   const ProviderScope(
//     child: MyApp()
//     ),
//     );
void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => FavoritesProvider(),
    child: const MyApp(),
  ),
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  
  void _setFilters(Map<String, bool> filtersData) {
    setState(() {
      _filters = filtersData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          hintColor: Colors.pink[100],
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyLarge: const TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                ),
                bodyMedium: const TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                ),
                titleMedium: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold),
              )),
      //home: TabsScreen(),
      routes: {
        '/': (context) =>  TabsScreen(),
        MealDetailScreen.routeName: (context) =>  MealDetailScreen(),
        SearchScreen.routeName: (context) =>  SearchScreen(),
       
        CategoryMealsScreen.routeName: ((context) =>
            CategoryMealsScreen(_availableMeals)),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
      },

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meal App"),
      ),
      //body: CategoriesScreen(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
