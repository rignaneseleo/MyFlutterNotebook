import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:my_template/core/logging/log.dart';
import 'package:my_template/core/router/app_router.dart';
import 'package:my_template/core/router/app_router_provider.dart';
import 'package:my_template/shared/providers/device_info_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:universal_platform/universal_platform.dart';

part 'notification_api.g.dart';

@Riverpod(keepAlive: true)
NotificationsService notificationService(NotificationServiceRef ref) =>
    NotificationsService(ref);

void handleMessage({
  required AppRouter appRouter,
  Map<String, dynamic>? data,
}) {
  Log.info(notificationServiceProvider, "Received notification data: $data");
  if (data == null) return;
}

class NotificationsService {
  NotificationsService(this.ref) {
    initFirebaseMsg();
  }

  Future<String?> initFirebaseMsg() async {
    Log.trace(notificationServiceProvider, "initPushNotifications");
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _firebaseMessaging.getInitialMessage().then(
          (n) => handleMessage(
            data: n?.data,
            appRouter: ref.read(appRouterProvider),
          ),
        );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (n) => handleMessage(
        data: n.data,
        appRouter: ref.read(appRouterProvider),
      ),
    );
    FirebaseMessaging.onMessage.listen(
      (n) => handleMessage(
        data: n.data,
        appRouter: ref.read(appRouterProvider),
      ),
    );

    try {
      _apnToken = await _firebaseMessaging.getToken();
      Log.info(
        notificationServiceProvider,
        "Firebase notification token: $_apnToken",
      );
    } on Exception catch (e) {
      Log.error(notificationServiceProvider, "Error getting APNS token: $e");
    }
    return _apnToken;
  }

  final NotificationServiceRef ref;

  String? _apnToken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<bool> needsNotificationPermission() async {
    if (UniversalPlatform.isIOS) {
      return true;
    } else if (UniversalPlatform.isAndroid) {
      final deviceInfo = ref.read(deviceInfoProvider) as AndroidDeviceInfo;
      return deviceInfo.version.sdkInt >= 33;
    }
    return false;
  }

  Future<bool> isNotificationAuthorized() async {
    if (!await needsNotificationPermission()) return true;

    final notificationSettings =
        await _firebaseMessaging.getNotificationSettings();
    return notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized;
  }

  Future<bool> askPermission() async {
    if (await isNotificationAuthorized()) return true;

    Log.info(
      notificationServiceProvider,
      "Requesting Firebase notification permission...",
    );
    final settings = await _firebaseMessaging.requestPermission();
    final newNotifAuth =
        settings.authorizationStatus == AuthorizationStatus.authorized;
    Log.info(
      notificationServiceProvider,
      "New Notification permission: $newNotifAuth",
    );
    return newNotifAuth;
  }

  Future<void> subscribeTo(String topic, bool subscribe) async {
    Log.info(notificationServiceProvider, "subscribeTo $topic -> $subscribe");
    if (subscribe) {
      await _firebaseMessaging.subscribeToTopic(topic);
    } else {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
    }
  }
}
