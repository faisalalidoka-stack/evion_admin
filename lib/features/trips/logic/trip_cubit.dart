import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/trip_status.dart';
import '../data/trip_repository.dart';
import '../models/trip_model.dart';
import 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  final TripRepository repository;

  TripCubit(this.repository) : super(const TripState());

  StreamSubscription<List<TripModel>>? _subscription;

  void loadTrips() {
    _subscription?.cancel();

    emit(state.copyWith(loading: true));

    _subscription = repository.streamTrips().listen((trips) {
      emit(state.copyWith(loading: false, trips: trips));
    }, onError: (e) {
      emit(state.copyWith(loading: false, errorMessage: e.toString()));
    });
  }

  Future<void> addTrip(TripModel trip) async {
    try {
      await repository.addTrip(trip);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> updateTrip(TripModel trip) async {
    try {
      await repository.updateTrip(trip);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> deleteTrip(String id) async {
    try {
      await repository.deleteTrip(id);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> updateStatus(String id, TripStatus status) async {
    try {
      await repository.updateStatus(id, status);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void setStatusFilter(TripStatus? status) {
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