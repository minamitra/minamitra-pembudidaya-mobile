import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'profile_member_state.dart';

class ProfileMemberCubit extends Cubit<ProfileMemberState> {
  ProfileMemberCubit() : super(const ProfileMemberState());

  Future<void> init() async {}

  void changeTabIndex(int index) {
    emit(state.copyWith(status: GlobalState.onUpdating));
    emit(state.copyWith(
      status: GlobalState.loaded,
      tabIndex: index,
    ));
  }
}
