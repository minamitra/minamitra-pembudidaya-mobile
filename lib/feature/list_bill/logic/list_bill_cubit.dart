import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'list_bill_state.dart';

class ListBillCubit extends Cubit<ListBillState> {
  ListBillCubit() : super(const ListBillState());

  void changeFilter(String filter) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    emit(
      state.copyWith(
        status: GlobalState.loaded,
        filter: filter,
      ),
    );
  }
}
