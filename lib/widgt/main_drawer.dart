import 'package:meal_app/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/screens/filters_screen.dart';
import 'package:meal_app/screens/search_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});
  Widget buildListTile(String title, IconData icon, Function() tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(title,
          style: const TextStyle(
              fontSize: 24,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold)),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
          height: 120,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          color: Theme.of(context).hintColor,
          alignment: Alignment.centerLeft,
          child: Text(
            "Cooking up",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        buildListTile("Meal", Icons.restaurant, () {
          Navigator.of(context).pushReplacementNamed('/');
        }),
        buildListTile("Filters", Icons.settings, () {
          Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
        }),
        buildListTile("Search", Icons.search, () {
          Navigator.of(context).pushReplacementNamed(SearchScreen.routeName);
        }),
        // buildListTile("Notifications", Icons.notifications, () {
        //   // Handle notification tap
        // }),
        buildListTile("Notifications", Icons.notifications, () {
          notificationService.showLunchNotification();
          Navigator.of(context).pop();   // يقفل الـ drawer ليظهر الإشعار بوضوح
        }),
      ]),
    );
  }
}
