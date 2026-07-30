import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/reservation_status.dart';
import '../data/reservation_repository.dart';
import '../models/reservation_model.dart';
import 'reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  final ReservationRepository repository;

  ReservationCubit(this.repository) : super(const ReservationState());

  StreamSubscription<List<ReservationModel>>? _subscription;

  void loadReservations() {
    _subscription?.cancel();

    emit(state.copyWith(loading: true));

    _subscription = repository.streamReservations().listen((reservations) {
      emit(state.copyWith(loading: false, reservations: reservations));
    }, onError: (e) {
      emit(state.copyWith(loading: false, errorMessage: e.toString()));
    });
  }

  Future<void> addReservation(ReservationModel reservation) async {
    try {
      await repository.addReservation(reservation);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> updateReservation(ReservationModel reservation) async {
    try {
      await repository.updateReservation(reservation);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> deleteReservation(String id) async {
    try {
      await repository.deleteReservation(id);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> updateStatus(String id, ReservationStatus status) async {
    try {
      await repository.updateStatus(id, status);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void setStatusFilter(ReservationStatus? status) {
    emit(
      status == null
          ? state.copyWith(clearStatusFilter: true)
          : state.copyWith(statusFilter: status),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}