import 'package:flutter/material.dart';
import 'package:meal_app/dummy_data.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/mail_detail_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';

import 'modules/meal.dart';
import 'screens/category_meals_screen.dart';
import 'screens/filters_screen.dart';

void main() => runApp(const MyApp());

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
  List<Meal> _favoriteMeals = [];
  void _setFilters(Map<String, bool> _filtersData) {
    setState(() {
      _filters = _filtersData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        ;
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        ;
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        ;
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        ;
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    //remove meal from favoriate when  the meal is already in favoriat
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

//to see if this meal is already in favoriate meal or not,replace the star icon
  bool isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.amber,
          accentColor: Colors.pink[300],
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 50, 50, 1),
                ),
                subtitle1: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold),
              )),
      //home: TabsScreen(),
      routes: {
        '/': (context) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName: ((context) =>
            CategoryMealsScreen(_availableMeals)),
        MealDetailScreen.routeName: ((context) =>
            MealDetailScreen(_toggleFavorite, isMealFavorite)),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_filters, _setFilters),
      },
      //const MyHomePage(),
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
        title: Text("Meal App"),
      ),
      //body: CategoriesScreen(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
