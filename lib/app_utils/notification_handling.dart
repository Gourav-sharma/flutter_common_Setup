import 'package:bloc_structure/app_utils/app_logs.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../api_calling/constant.dart';
import '../api_calling/session_manager.dart';

class NotificationService {
  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initialize() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) {
    AppLogs.showInfoLogs('Notification payload: ${notificationResponse.payload}');
    if (notificationResponse.payload != null) {
      // Handle payload, e.g., navigation
    }
  }

  Future<void> showNotification(
      int id, String title, String body, String? payload) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: DarwinNotificationDetails());

    if (await getNotificationStatus()) { // Use the private method
      await flutterLocalNotificationsPlugin.show(
          id, title, body, notificationDetails,
          payload: payload);
    } else {
      AppLogs.showInfoLogs('Notification not sent');
    }
  }

  Future<void> scheduleNotification(
      int id, String title, String body, DateTime scheduledTime, String? payload) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'your_scheduled_channel_id',
      'your_scheduled_channel_name',
      channelDescription: 'your_scheduled_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: DarwinNotificationDetails());

    if (await getNotificationStatus()) { // Use the private method
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledTime, tz.getLocation('your_timezone')),
          notificationDetails,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
          payload: payload,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
    } else {
      AppLogs.showErrorLogs('Notification not scheduled');
    }
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> saveNotificationStatus(bool isEnabled) async {
    await storage.write(SessionManagerKeys.isNotificationsEnabled, isEnabled);
  }

  Future<bool> getNotificationStatus() async {
    return storage.read(SessionManagerKeys.isNotificationsEnabled) ?? true; // Default to true if not set
  }

  // Make this method PRIVATE (starts with _)
  bool shouldSendNotification({
    bool? isLoggedIn,
    bool isNotificationEnabled = true,
    bool? isNotificationScheduled,
  }) {
    saveNotificationStatus(isNotificationEnabled);
    return isNotificationEnabled; // Example logic: Only checks if notifications are enabled.
  }
}