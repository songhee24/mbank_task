import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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

  MfrBloc({required this.mfrRepository}) : super(const MfrListState()) {
    on<MfrFetched>(
      _asyncGetManufacturers,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _asyncGetManufacturers(
    MfrFetched event,
    Emitter<MfrState> emit,
  ) async {
    final currentState = state as MfrListState;
    try {
      if (currentState.status == RequestStatus.initial) {
        final manufacturers = await mfrRepository.fetchManufacturers(1);
        final loadedData = currentState.copyWith(
          manufacturers: manufacturers,
          hasReachedMax: false,
          status: RequestStatus.success,
        );
        return emit(loadedData);
      }

      final currentPage = (currentState.manufacturers.length / 100).ceil() + 1;
      final manufacturers = await mfrRepository.fetchManufacturers(currentPage);
      if (manufacturers.isEmpty) {
        emit(currentState.copyWith(hasReachedMax: true));
      } else {
        emit(currentState.copyWith(
            manufacturers: List.of(currentState.manufacturers)
              ..addAll(manufacturers),
            hasReachedMax: false,
            status: RequestStatus.success));
      }
    } catch (_) {
      emit(currentState.copyWith(status: RequestStatus.failure));
    }
  }
}
