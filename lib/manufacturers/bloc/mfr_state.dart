part of 'mfr_bloc.dart';

enum RequestStatus { initial, success, failure }

final class MfrState extends Equatable {
  final RequestStatus status;
  final List<MfrModel> manufacturers;
  final bool hasReachedMax;

  const MfrState({
    this.status = RequestStatus.initial,
    this.manufacturers = const <MfrModel>[],
    this.hasReachedMax = false,
  });

  MfrState copyWith({
    RequestStatus? status,
    List<MfrModel>? manufacturers,
    bool? hasReachedMax,
  }) {
    return MfrState(
      status: status ?? this.status,
      manufacturers: manufacturers ?? this.manufacturers,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [manufacturers, hasReachedMax];
}
