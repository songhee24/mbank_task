import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'network_state.dart';
part 'network_event.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  late final Connectivity connectivity;

  NetworkBloc() : super(NetworkConnectedState()) {
    connectivity = Connectivity();
    on<NetworkConnected>((event, emit) {
      emit(NetworkConnectedState());
    });

    on<NetworkDisconnected>((event, emit) {
      emit(NetworkDisconnectedState());
    });

    connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        add(NetworkDisconnected());
      } else {
        add(NetworkConnected());
      }
    });
  }
}
