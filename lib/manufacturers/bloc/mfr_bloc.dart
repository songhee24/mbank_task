import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:mbank_task/manufacturers/data/mfr_repository.dart';
import 'package:mbank_task/manufacturers/models/mfr_model.dart';

part 'mfr_event.dart';
part 'mfr_state.dart';
part 'mfr_details_state.dart';

const throttleDuration = Duration(milliseconds: 500);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class MfrBloc extends Bloc<MfrEvent, MfrState> {
  final MfrRepository mfrRepository;

  MfrBloc({required this.mfrRepository}) : super(const MfrState()) {
    on<MfrFetched>(
      _asyncGetManufacturers,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _asyncGetManufacturers(
    MfrFetched event,
    Emitter<MfrState> emit,
  ) async {
    try {
      if (state.status == RequestStatus.initial) {
        final manufacturers = await mfrRepository.fetchManufacturers(1);
        final loadedData = state.copyWith(
            manufacturers: manufacturers,
            hasReachedMax: false,
            status: RequestStatus.success);
        return emit(loadedData);
      }

      final currentPage = (state.manufacturers.length / 100).ceil() + 1;
      final manufacturers = await mfrRepository.fetchManufacturers(currentPage);
      if (manufacturers.isEmpty) {
        emit(state.copyWith(hasReachedMax: true));
      } else {
        emit(state.copyWith(
            manufacturers: List.of(state.manufacturers)..addAll(manufacturers),
            hasReachedMax: false,
            status: RequestStatus.success));
      }
    } catch (_) {
      emit(state.copyWith(status: RequestStatus.failure));
    }
  }
}
