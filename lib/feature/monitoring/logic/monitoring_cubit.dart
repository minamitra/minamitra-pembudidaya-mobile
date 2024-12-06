import 'package:bloc/bloc.dart';

class MonitoringCubit extends Cubit<int> {
  MonitoringCubit() : super(0);

  void onChangeIndex(int index) {
    emit(index);
  }
}
