import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/home/home_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/pond/pond_service.dart';
import 'package:minamitra_pembudidaya_mobile/feature/activity/logic/activity_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/logic/home_cubit.dart';
import 'package:minamitra_pembudidaya_mobile/feature/home/views/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(HomeServiceImpl.create())..init(),
        ),
        BlocProvider<ActivityCubit>(
          create: (context) => ActivityCubit(PondServiceImpl.create())..init(),
        ),
      ],
      child: const HomeView(),
    );
  }
}
