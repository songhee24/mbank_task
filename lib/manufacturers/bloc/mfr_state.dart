part of 'mfr_bloc.dart';

enum RequestStatus { initial, success, failure }

@immutable
abstract class MfrState extends Equatable {
  const MfrState();

  @override
  List<Object?> get props => [];
}

final class MfrListState extends MfrState {
  final RequestStatus status;
  final List<MfrModel> manufacturers;
  final bool hasReachedMax;

  const MfrListState({
    this.status = RequestStatus.initial,
    this.manufacturers = const <MfrModel>[],
    this.hasReachedMax = false,
  });

  MfrListState copyWith({
    RequestStatus? status,
    List<MfrModel>? manufacturers,
    bool? hasReachedMax,
  }) {
    return MfrListState(
      status: status ?? this.status,
      manufacturers: manufacturers ?? this.manufacturers,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [manufacturers, hasReachedMax, status];
}

final class MfrDetailsState extends MfrState {
  final RequestStatus? status;
  final MfrDetailsModel? mfrDetailsModel;

  const MfrDetailsState({this.mfrDetailsModel, this.status});

  @override
  List<Object?> get props => [mfrDetailsModel, status];
}
