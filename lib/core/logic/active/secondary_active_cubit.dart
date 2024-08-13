import 'package:flutter_bloc/flutter_bloc.dart';

class SecondaryActiveCubit extends Cubit<bool> {
  SecondaryActiveCubit(super.status);

  void toggle(bool status) => emit(status);
}
