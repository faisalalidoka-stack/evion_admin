import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/bus_status.dart';
import '../data/fleet_repository.dart';
import '../models/bus_model.dart';
import 'fleet_state.dart';

class FleetCubit extends Cubit<FleetState> {
  final FleetRepository repository;

  FleetCubit(this.repository) : super(const FleetState());

  StreamSubscription<List<BusModel>>? _subscription;

  void loadFleet() {
    _subscription?.cancel();

    emit(state.copyWith(loading: true));

    _subscription = repository.streamBuses().listen((buses) {
      emit(state.copyWith(loading: false, buses: buses));
    }, onError: (e) {
      emit(state.copyWith(loading: false, errorMessage: e.toString()));
    });
  }

  Future<void> addBus(BusModel bus) async {
    try {
      await repository.addBus(bus);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> updateBus(BusModel bus) async {
    try {
      await repository.updateBus(bus);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> deleteBus(String id) async {
    try {
      await repository.deleteBus(id);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> assignDriver({
    required String busId,
    required String driverId,
    required String driverName,
  }) async {
    try {
      await repository.assignDriver(busId, driverId, driverName);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> updateStatus(String busId, BusStatus status) async {
    try {
      await repository.updateStatus(busId, status);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> seedSampleData() async {
    try {
      await repository.seedSampleDataIfEmpty();
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void setStatusFilter(BusStatus? status) {
    emit(
      status == null
          ? state.copyWith(clearStatusFilter: true)
          : state.copyWith(statusFilter: status),
    );
  }

  void setActiveFilter(bool? active) {
    emit(
      active == null
          ? state.copyWith(clearActiveFilter: true)
          : state.copyWith(activeFilter: active),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}