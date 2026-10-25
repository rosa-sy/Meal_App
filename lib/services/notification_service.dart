import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(settings);

    // طلب إذن الإشعارات (أندرويد 13+)، من نفس الـ README اللي لصقتيه
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> showLunchNotification() async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'lunch_channel',          // رقم القناة
        'Lunch Reminders',        // اسمها اللي يظهر للمستخدم بالإعدادات
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    await _plugin.show(0, 'Lunch Time', 'choose new dish', details);
  }
}

// نسخة وحدة نستخدمها بكل التطبيق
final notificationService = NotificationService();