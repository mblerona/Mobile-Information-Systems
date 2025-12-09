import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: androidSettings,
    );

    await _plugin.initialize(initSettings);
  }

  static Future<void> showRandomRecipeNotification(String body) async {
    const androidDetails = AndroidNotificationDetails(
      'random_recipe_channel',
      'Random Recipe',
      channelDescription: 'Notifications about random recipe of the day',
      importance: Importance.high,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _plugin.show(
      0,
      'Random recipe of the day',
      body,
      details,
    );
  }
}
