import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveCubit extends Cubit<bool> {
  ActiveCubit(super.status);

  void toggle(bool status) => emit(status);
}
