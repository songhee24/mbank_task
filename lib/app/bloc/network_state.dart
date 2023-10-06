part of 'network_bloc.dart';

abstract class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object> get props => [];
}

class NetworkConnectedState extends NetworkState {}

class NetworkDisconnectedState extends NetworkState {}
