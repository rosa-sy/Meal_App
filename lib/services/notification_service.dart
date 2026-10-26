import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meal_app/navigator_key.dart';
import 'package:meal_app/screens/search_screen.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        navigatorKey.currentState?.pushNamed(SearchScreen.routeName); // Replace with your desired route
        // You can navigate to a specific screen or perform any action here
      });

    
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> showLunchNotification() async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'lunch_channel',         
        'Lunch Reminders',        
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    await _plugin.show(0, 'Lunch Time', 'choose new dish', details);
  }
}

final notificationService = NotificationService();