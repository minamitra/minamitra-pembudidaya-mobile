part of 'notification_cubit.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.status = GlobalState.initial,
    this.errorMessage = '',
    this.notificationListResponse,
  });

  final GlobalState status;
  final String errorMessage;
  final NotificationListResponse? notificationListResponse;

  NotificationState copyWith({
    GlobalState? status,
    String? errorMessage,
    NotificationListResponse? notificationListResponse,
  }) {
    return NotificationState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      notificationListResponse:
          notificationListResponse ?? this.notificationListResponse,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        notificationListResponse ?? NotificationListResponse(),
      ];
}
