import 'package:equatable/equatable.dart';

sealed class ConnectionCheckState extends Equatable {
  const ConnectionCheckState();

  @override
  List<Object> get props => [];
}

final class ConnectionCheckInitial extends ConnectionCheckState {}

final class ConnectionCheckConnected extends ConnectionCheckState {}

final class ConnectionCheckDisconnected extends ConnectionCheckState {}
