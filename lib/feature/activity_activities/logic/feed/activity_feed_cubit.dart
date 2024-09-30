import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minamitra_pembudidaya_mobile/core/exceptions/app_exceptions.dart';
import 'package:minamitra_pembudidaya_mobile/core/services/feed_activity/feed_activity_service.dart';
import 'package:minamitra_pembudidaya_mobile/core/utils/app_global_state.dart';

part 'activity_feed_state.dart';

class ActivityFeedCubit extends Cubit<ActivityFeedState> {
  ActivityFeedCubit(this.service) : super(const ActivityFeedState());

  FeedActivityService service;

  Future<void> onDeleteFeedActivity(String id) async {
    emit(state.copyWith(status: GlobalState.showDialogLoading));
    try {
      await service.deleteFeedActivity(id);
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(status: GlobalState.successSubmit));
    } on AppException catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.message,
      ));
    } catch (e) {
      emit(state.copyWith(status: GlobalState.hideDialogLoading));
      emit(state.copyWith(
        status: GlobalState.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
