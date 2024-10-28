import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBottomNavCubit extends Cubit<int> {
  DashboardBottomNavCubit() : super(0);

  void changeIndex(int index) {
    emit(index);
  }
}
