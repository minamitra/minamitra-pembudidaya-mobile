import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/app.dart';
import 'package:minamitra_pembudidaya_mobile/core/injections/env.dart';
import 'package:minamitra_pembudidaya_mobile/firebase_options.dart';

// shortcut for app theme
TextTheme appTextTheme(BuildContext context) => Theme.of(context).textTheme;
ColorScheme appColorScheme(BuildContext context) =>
    Theme.of(context).colorScheme;
// Set your environment here
const Environment env = Environment.development;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return App();

    // MultiRepositoryProvider(
    //   providers: [
    //     // RepositoryProvider<AuthenticationRepository>(
    //     //   create: (context) => authenticationRepository,
    //     // ),
    //   ],
    //   child: MultiBlocProvider(
    //     providers: [
    //       // BlocProvider<AuthenticationCubit>(
    //       //   create: (context) => AuthenticationCubit(authenticationRepository)
    //       //     ..listeningStatus(),
    //       // ),
    //       // BlocProvider<UserCubit>(
    //       //   create: (context) => UserCubit(
    //       //     SharedPreferenceServiceImpl.create(),
    //       //     OutletServiceImpl.create(),
    //       //   ),
    //       // ),
    //       // BlocProvider<ConnectionCheckCubit>(
    //       //   create: (context) => ConnectionCheckCubit()..streamConnection(),
    //       // ),
    //       // BlocProvider<BluetoothPrinterCubit>(
    //       //   create: (context) => BluetoothPrinterCubit(),
    //       // ),
    //       // BlocProvider<HomeCubit>(
    //       //   create: (context) => HomeCubit(FinanceServiceImpl.create()),
    //       // ),
    //     ],
    //     child: App(),
    //   ),
    // );
  }
}
