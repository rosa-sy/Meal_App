import 'package:flutter/material.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/favorites_screen.dart';
import 'package:meal_app/screens/search_screen.dart';
import '../widgt/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
 

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
        'page': const CategoriesScreen(),
        'title': 'Categories',
      },
      {
        'page': const FavoritesScreen(),
        'title': 'Your Favorites',
      },
      {
        'page': const SearchScreen(),
        'title': 'Search',
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
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
        ],
      ),
      drawer: const MainDrawer(),
    );
  }
}
