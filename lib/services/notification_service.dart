// Dart
import 'dart:convert';
import 'dart:io';
// Flutter packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const notificationChannelId = 'airsoft_cascavel';
const notificationChannelName = 'Notificações';

@pragma('vm:entry-point')
void onBackgroundNotification(NotificationResponse? payload) async {
  // Handle taps on notifications while the app is in the background here.
  if (payload == null) return;
}

/// Local notifications (channels, show, progress). Kept independent of Firebase
/// so it can be used for in-app alerts as well as pushed messages.
///
/// NOT wired in `main()` yet — call [notificationInitialization] at startup once
/// notifications are needed.
class MyNotificationService {
  MyNotificationService({required this.ref});

  final Ref ref;

  final localNotifications = FlutterLocalNotificationsPlugin();

  void notificationInitialization() async {
    try {
      const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosSetting = DarwinInitializationSettings();

      const initSettings = InitializationSettings(android: androidSetting, iOS: iosSetting);

      await localNotifications.initialize(
        settings: initSettings,
        onDidReceiveNotificationResponse: onSelectNotification,
        onDidReceiveBackgroundNotificationResponse: onBackgroundNotification,
      );

      await createNotificationChannel();
    } catch (_) {}
  }

  void onSelectNotification(NotificationResponse? payload) async {
    if (payload == null) return;

    if (payload.notificationResponseType == NotificationResponseType.selectedNotificationAction) {
      return;
    }

    if (payload.notificationResponseType == NotificationResponseType.selectedNotification) {
      final raw = payload.payload;
      if (raw == null) return;

      jsonDecode(raw) as Map<String, dynamic>;

      // Route based on the decoded payload's `type` once deep links are defined.
      // Example: appRouter.push(AppRoutes.eventDetail, extra: data);
      return;
    }
  }

  Future<void> createNotificationChannel() async {
    if (!Platform.isAndroid) return;

    const androidChannel = AndroidNotificationChannel(
      notificationChannelId,
      notificationChannelName,
      importance: Importance.max,
      enableVibration: true,
    );

    await localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  void showNotification(int id, String title, String body, {String? payload}) {
    const androidDetails = AndroidNotificationDetails(
      notificationChannelId,
      notificationChannelName,
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );
    const iosDetails = DarwinNotificationDetails();

    localNotifications.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: const NotificationDetails(android: androidDetails, iOS: iosDetails),
      payload: payload,
    );
  }

  void cancelNotification(int id) => localNotifications.cancel(id: id);
}

final notificationProvider = Provider<MyNotificationService>(
  (ref) => MyNotificationService(ref: ref),
);
