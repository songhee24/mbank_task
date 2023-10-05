part of 'mfr_bloc.dart';

sealed class MfrEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class MfrFetched extends MfrEvent {}

final class MfrFetchedById extends MfrEvent {
  final int manufacturerId;

  MfrFetchedById({required this.manufacturerId});

}
