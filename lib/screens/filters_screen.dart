import 'package:flutter/material.dart';
import 'package:meal_app/widgt/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  // const FiltersScreen({super.key});
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  @override
  void initState() {
    // TODO: implement initState for savving state of filters
    _glutenFree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegan = widget.currentFilters['vegan']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    super.initState();
  }

  Widget buildSwitchListTile(
      String title, String description, bool currentValue, updatValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updatValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filter !"),
        actions: [
          IconButton(
              onPressed: () {
                final Map<String, bool> selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(selectedFilters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text("Adjust your meal selection",
              style: Theme.of(context).textTheme.titleLarge),
        ),
        Expanded(
            child: ListView(
          children: [
            buildSwitchListTile(
                "Lactose-free", "Only include lactose free meals", _lactoseFree,
                (newValue) {
              setState(() {
                _lactoseFree = newValue;
              });
            }),
            buildSwitchListTile(
                "Vegetarian", "Only include vegetarian meals", _vegetarian,
                (newValue) {
              setState(() {
                _vegetarian = newValue;
              });
            }),
            buildSwitchListTile(
                "Gluten-free", "Only include gluten free meals", _glutenFree,
                (newValue) {
              setState(() {
                _glutenFree = newValue;
              });
            }),
            buildSwitchListTile("Vegan", "Only include Vegan meals", _vegan,
                (newValue) {
              setState(() {
                _vegan = newValue;
              });
            }),
          ],
        )),
      ]),
      drawer: MainDrawer(),
    );
  }
}
