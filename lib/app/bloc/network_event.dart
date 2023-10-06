
part of 'network_bloc.dart';


abstract class NetworkEvent extends Equatable {
  const NetworkEvent();

  @override
  List<Object> get props => [];
}

class NetworkConnected extends NetworkEvent {}

class NetworkDisconnected extends NetworkEvent {}