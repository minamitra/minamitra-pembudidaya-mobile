import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:minamitra_pembudidaya_mobile/core/injections/injection.dart';
import 'package:minamitra_pembudidaya_mobile/core/local_storage/shared_pref_key.dart';
import 'package:minamitra_pembudidaya_mobile/core/local_storage/shared_pref_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/header_provider.dart';
import 'package:minamitra_pembudidaya_mobile/core/network/http_client.dart';

import 'package:minamitra_pembudidaya_mobile/core/services/cloud_messaging/cloud_messaging_endpoint.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_downloader.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_transition.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity_incident_detail/views/activity_incident_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/cultivation_note_detail/view/cultivation_note_detail_page.dart';
import 'package:minamitra_pembudidaya_mobile/feature/transaction_detail/views/transaction_detail_page.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class AppCloudMessaging {
  Future<void> setupFirebaseCloudMessagingWithFlutterNotifications(
    BuildContext context,
  );
  Future<void> setFirebaseCloudMessagingHandler(BuildContext context);
  void showFirebaseCloudNotificationWithFlutterNotification(
    RemoteMessage message,
  );
}

class AppCloudMessagingImpl implements AppCloudMessaging {
  // static String? fcmToken; // Variable to store the FCM token

  final FirebaseMessaging firebaseMessaging;
  final HttpClient httpClient;
  final HeaderProvider headerProvider;
  final CloudMessagingEndpoint endpoint;
  final SharedPreferenceService sharedPreferenceService;

  AppCloudMessagingImpl({
    required this.firebaseMessaging,
    required this.httpClient,
    required this.headerProvider,
    required this.endpoint,
    required this.sharedPreferenceService,
  });

  factory AppCloudMessagingImpl.create() {
    return AppCloudMessagingImpl(
      firebaseMessaging: FirebaseMessaging.instance,
      httpClient: Injection.httpClient,
      headerProvider: Injection.headerProvider,
      endpoint: CloudMessagingEndpoint(),
      sharedPreferenceService: SharedPreferenceServiceImpl.create(),
    );
  }

  // static final AppCloudMessaging _instance = AppCloudMessaging._internal();

  // factory AppCloudMessaging() => _instance;

  // AppCloudMessaging._internal();

  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // /// Create a [AndroidNotificationChannel] for heads up notifications
  // late AndroidNotificationChannel channel;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();

  /// A notification action which triggers a App navigation event
  // final String navigationActionId = 'id_3';

  @override
  Future<void> setupFirebaseCloudMessagingWithFlutterNotifications(
    BuildContext context,
  ) async {
    await firebaseMessaging.setAutoInitEnabled(true);

    await _createNotificationChannel(
      flutterLocalNotificationsPlugin,
      id: 'general',
      name: 'General',
      description: 'Notification general purposes',
      sound: 'default_notif',
    );

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions();

    bool isGrantedNotif = await checkNotificationPermission();

    if (!isGrantedNotif) {
      await Permission.notification.request();
    }

    // Requesting permission for notifications
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint(
      'User granted notifications permission: ${settings.authorizationStatus}',
    );
  }

  /// Create channel
  Future<void> _createNotificationChannel(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, {
    required String id,
    String? name,
    String? description,
    String? sound,
  }) async {
    var androidNotificationChannel = AndroidNotificationChannel(
      id,
      name ?? '',
      description: description,
      importance: Importance.max,
      enableLights: true,
      playSound: true,
      // sound: RawResourceAndroidNotificationSound(sound),
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          androidNotificationChannel,
        );
  }

  @override
  Future<void> setFirebaseCloudMessagingHandler(BuildContext context) async {
    // Setting up Firebase Cloud Messaging with Flutter Local Notifications
    await setUpFirebaseCloudMessagingToken();

    // Listening for incoming messages while the app is in the foreground
    streamNotificationTokenFirebase();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    DarwinInitializationSettings initializationSettingsDarwin =
        const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            if (notificationResponse.payload != null) {
              final Map<String, dynamic> notificationData =
                  json.decode(notificationResponse.payload!);
              log('handleContainScreen from flutter local notification');
              handleContainScreen(context, notificationData);
            }
            break;
          case NotificationResponseType.selectedNotificationAction:
            // if (notificationResponse.actionId == navigationActionId) {
            //   selectNotificationStream.add(notificationResponse.payload);
            // }
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // Handling the initial message received when the app is launched from dead (killed state)
    // When the app is killed and a new notification arrives when user clicks on it
    // It gets the data to which screen to open
    firebaseMessaging.getInitialMessage().then((message) {
      if (message != null) {
        sharedPreferenceService.setSharedPreference(
          AppSharedPrefKey.isHasNotificationKey,
          'true',
        );
        showFirebaseCloudNotificationWithFlutterNotification(message);
      }
    });

    // Listening for incoming messages while the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      sharedPreferenceService.setSharedPreference(
        AppSharedPrefKey.isHasNotificationKey,
        'true',
      );
      showFirebaseCloudNotificationWithFlutterNotification(message);
    });

    // Handling a notification click event when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationClick(context, message);
    });
  }

  void notificationNavigation(
    BuildContext context,
    String route,
    String id,
  ) {
    if (kDebugMode) {
      print('----- handleContainScreen $route $id');
    }

    try {
      switch (route) {
        case '/cultivation-note-detail-page':
          Navigator.of(context).push(
            AppTransition.pushTransition(
              CultivationNoteDetailPage(id: id),
              CultivationNoteDetailPage.routeSettings,
            ),
          );
          break;
        case '/transaction-detail':
          Navigator.of(context).push(
            AppTransition.pushTransition(
              TransactionDetailPage(orderId: id),
              TransactionDetailPage.routeSettings(),
            ),
          );
          break;
        case '/activity-incident-detail':
          Navigator.of(context).push(
            AppTransition.pushTransition(
              ActivityIncidentDetailPage(incidentID: id),
              ActivityIncidentDetailPage.routeSettings(),
            ),
          );
        default:
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void handleContainScreen(
    BuildContext context,
    Map<String, dynamic> notificationData,
  ) {
    log('handleContainScreen ${notificationData.toString()}');
    if (notificationData.containsKey('route')) {
      final String route = notificationData['route'];
      final String id = notificationData['id'];
      notificationNavigation(context, route, id);
    }
  }

  // Handling a notification click event by navigating to the specified screen
  void _handleNotificationClick(BuildContext context, RemoteMessage message) {
    final notificationData = message.data;
    log('handle from on click firebase');
    handleContainScreen(context, notificationData);
  }

  @override
  void showFirebaseCloudNotificationWithFlutterNotification(
    RemoteMessage message,
  ) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            message.data['channelId'] ??
                'general', // To set dynamic sound. Please create contract API with BE about the channelID and create the channel id on this code
            message.data['channelName'] ?? 'General',
            channelDescription: message.data['channelDescription'],
            icon: 'launch_background',
            importance: Importance.max,
            priority: Priority.high,
            enableLights: true,
            playSound: true,
            channelShowBadge: true,
            // sound: const RawResourceAndroidNotificationSound('default_notif'),
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentSound: true,
            presentBadge: true,
          ),
        ),
        payload: json.encode(message.data),
        // payload: message.data,
      );
    }
  }

  Future<void> setUpFirebaseCloudMessagingToken() async {
    SharedPreferenceService credentialsStorageService =
        SharedPreferenceServiceImpl.create();

    String? token = await credentialsStorageService
        .getSharedPreference(AppSharedPrefKey.cloudTokenKey);

    if (token == null || token.isEmpty) {
      final fcmToken = await firebaseMessaging.getToken(
        vapidKey:
            'BICr4m3c0MduL4TBiQfSe35Me4x5smsqCS26vFSx_nndqEHTC3qbEy7HHY5KbZGSn918F9zZ9PJT-Us3URvYyAU',
      );
      if (fcmToken != null) {
        await credentialsStorageService.setSharedPreference(
          AppSharedPrefKey.cloudTokenKey,
          fcmToken,
        );
        // sending token to API
        log('FCM Token: $fcmToken');
        await subscribeFCMToken(fcmToken);
      }
    } else {
      // Sending token to API
      log('FCM Token: $token');
      await subscribeFCMToken(token);
    }
  }

  Future<void> streamNotificationTokenFirebase() async {
    SharedPreferenceService credentialsStorageService =
        SharedPreferenceServiceImpl.create();
    firebaseMessaging.onTokenRefresh.listen((fcmToken) async {
      await credentialsStorageService.setSharedPreference(
        AppSharedPrefKey.cloudTokenKey,
        fcmToken,
      );
      // sending token to API
      await subscribeFCMToken(fcmToken);
    }).onError((err) {
      // Error getting token.
    });
  }

  Future<void> subscribeFCMToken(String token) async {
    final url = endpoint.postSendToken();
    final header = await headerProvider.headers;
    await httpClient.post(
      url,
      header,
      json.encode(
        {'fcm_token': token},
      ),
    );
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  if (kDebugMode) {
    print('------- notificationTapBackground');
  }
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
      'notification action tapped with input: ${notificationResponse.input}',
    );
  }
}
