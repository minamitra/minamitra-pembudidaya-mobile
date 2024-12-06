import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/app.dart';
import 'package:minamitra_pembudidaya_mobile/core/authentications/authentication_repository.dart';
import 'package:minamitra_pembudidaya_mobile/core/injections/env.dart';
import 'package:minamitra_pembudidaya_mobile/core/local_storage/shared_pref_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/authentication/authentication_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/dashboard/dashboard_bottom_nav_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/logic/user/user_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/cloud_messaging/cloud_messaging_service.dart';
import 'package:minamitra_pembudidaya_mobile/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage message,
  // AppCloudMessaging mainCloudMessaging,
) async {
  await Firebase.initializeApp();
  // mainCloudMessaging
  //     .showFirebaseCloudNotificationWithFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  debugPrint('Handling a background message: ${message.notification!.title}');
}

// shortcut for app theme
TextTheme appTextTheme(BuildContext context) => Theme.of(context).textTheme;
ColorScheme appColorScheme(BuildContext context) =>
    Theme.of(context).colorScheme;
// Set your environment here
const Environment env = Environment.development;
late AppCloudMessaging appCloudMessaging;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  // FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  appCloudMessaging = AppCloudMessagingImpl.create();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AuthenticationRepository authenticationRepository =
      AuthenticationRepositoryImpl.create();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => authenticationRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationCubit>(
            create: (context) => AuthenticationCubit(authenticationRepository)
              ..listeningStatus(),
          ),
          BlocProvider<UserCubit>(
            create: (context) => UserCubit(
              authenticationRepository,
              SharedPreferenceServiceImpl.create(),
            ),
          ),
          BlocProvider(create: (context) => DashboardBottomNavCubit()),
          // BlocProvider<UserCubit>(
          //   create: (context) => UserCubit(
          //     SharedPreferenceServiceImpl.create(),
          //     OutletServiceImpl.create(),
          //   ),
          // ),
          // BlocProvider<ConnectionCheckCubit>(
          //   create: (context) => ConnectionCheckCubit()..streamConnection(),
          // ),
          // BlocProvider<BluetoothPrinterCubit>(
          //   create: (context) => BluetoothPrinterCubit(),
          // ),
          // BlocProvider<HomeCubit>(
          //   create: (context) => HomeCubit(FinanceServiceImpl.create()),
          // ),
        ],
        child: const App(),
      ),
    );
  }
}
