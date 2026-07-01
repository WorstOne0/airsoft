// Dart
import 'dart:convert';
import 'dart:io';
// Flutter packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// Services
import '/services/notification_service.dart';

/// Firebase Cloud Messaging wrapper. Requests permission, listens for messages
/// and forwards them to [MyNotificationService] for display.
///
/// NOT wired in `main()` yet — Firebase must be initialized first
/// (`Firebase.initializeApp` + firebase_options.dart). Call
/// [firebaseInitialization] once that is in place.
class FirebaseMessagingService {
  FirebaseMessagingService({required this.ref});

  final Ref ref;

  final firebaseMessaging = FirebaseMessaging.instance;

  void firebaseInitialization() {
    firebaseMessaging.requestPermission(alert: true, announcement: true, badge: true, sound: true);
    firebaseMessaging.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

    FirebaseMessaging.onMessage.listen(handleShowMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleOpenApp);
  }

  void handleInitialMessage() async {
    final message = await firebaseMessaging.getInitialMessage();
    if (message == null) return;

    handleRedirect(message.data);
  }

  void handleOpenApp(RemoteMessage message) async => handleRedirect(message.data);

  void handleRedirect(Map<String, dynamic> payload) {
    // Route based on `payload["type"]` once deep links are defined.
    // Example: appRouter.push(AppRoutes.eventDetail, extra: payload);
    switch (payload["type"]) {
      default:
        break;
    }
  }

  Future<void> handleShowMessage(RemoteMessage message) async {
    final notification = message.notification;
    if (notification == null) return;

    if (Platform.isAndroid && notification.android != null) {
      ref.read(notificationProvider).showNotification(
            notification.android.hashCode,
            notification.title ?? "",
            notification.body ?? "",
            payload: jsonEncode(message.data),
          );
    }

    if (Platform.isIOS && notification.apple != null) {
      ref.read(notificationProvider).showNotification(
            notification.apple.hashCode,
            notification.title ?? "",
            notification.body ?? "",
            payload: jsonEncode(message.data),
          );
    }
  }

  Future<String?> getDeviceToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (_) {
      return null;
    }
  }

  void subscribeToTopic(String topic) => FirebaseMessaging.instance.subscribeToTopic(topic);
  void unsubscribeFromTopic(String topic) => FirebaseMessaging.instance.unsubscribeFromTopic(topic);
}

final firebaseMessagingProvider = Provider<FirebaseMessagingService>(
  (ref) => FirebaseMessagingService(ref: ref),
);
