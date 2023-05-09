import 'package:flutter/material.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/favorites_screen.dart';
import '../modules/meal.dart';
import '../widgt/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  // TabsScreen({super.key});
  final List<Meal> favoriatMeals;
  TabsScreen(this.favoriatMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, dynamic>> pages;
  int selectedPageIndex = 0;
  @override
  void initState() {
    pages = [
      {
        'page': CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': FavoritesScreen(widget.favoriatMeals),
        'title': 'Your Favorites',
      }
    ];
    // TODO: implement initState
    super.initState();
  }

  void _selectPage(int value) {
    setState(() {
      selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(pages[selectedPageIndex]['title'])),
      body: pages[selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Theme.of(context).cardColor,
        unselectedItemColor: Colors.white,
        currentIndex: selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
