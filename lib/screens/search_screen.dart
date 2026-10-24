import 'package:flutter/material.dart';
import 'package:meal_app/modules/search_meal.dart';
import 'package:meal_app/services/fetchSearchMeal.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const routeName = 'search_screen';
  
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  Future<List<SearchMeal>>? _searchFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search meals...',
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                setState(() {
                  _searchFuture = fetchSearchMeals(value);  
                });
              },
            ),
          ),
          Expanded(
            child: _searchFuture == null
                ? const Center(child: Text('Type a meal name to search'))
                : FutureBuilder<List<SearchMeal>>(
                    future: _searchFuture,         
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No results found.'));
                      } else {
                        final meals = snapshot.data!;
                        return ListView.builder(
                          itemCount: meals.length,
                          itemBuilder: (context, index) {
                            final meal = meals[index];
                            return ListTile(
                              leading: Image.network(meal.strMealThumb),
                              title: Text(meal.strMeal),
                            );
                          },
                        );
                      }
                   
                    },
                  ),
          ),
        ],
      ),
    );
  }
}