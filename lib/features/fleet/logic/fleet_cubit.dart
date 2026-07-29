import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/fleet_repository.dart';
import '../models/bus_model.dart';
import 'fleet_state.dart';
import 'dart:async';

class FleetCubit extends Cubit<FleetState> {
  final FleetRepository repository;

  FleetCubit(this.repository) : super(const FleetState());

  StreamSubscription<List<BusModel>>? _subscription;

  void loadFleet() {
    _subscription?.cancel();

    emit(
      state.copyWith(
        loading: true,
      ),
    );

    _subscription =
        repository.streamBuses().listen((buses) {
          emit(
            state.copyWith(
              loading: false,
              buses: buses,
              filteredBuses: buses,
            ),
          );
        });
  }

  Future<void> refresh() async {
    try {
      emit(
        state.copyWith(
          buses: repository.getBuses(),
          filteredBuses: repository.getBuses(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
    void updateStatus(
        String busId,
        String status,
        ) {
      repository.updateStatus(
        busId,
        status,
      );

      refresh();
    }

  }

  Future<void> addBus(BusModel bus) async {
    await repository.addBus(bus);
  }

  Future<void> updateBus(BusModel bus) async {
    await repository.updateBus(bus);
  }

  Future<void> deleteBus(String id) async {
    await repository.deleteBus(id);
  }

  Future<void> updateStatus(
      String id,
      String status,
      ) async {
    await repository.updateStatus(id, status);
  }

  Future<void> assignDriver({
    required String busId,
    required String driverId,
    required String driverName,
  }) async {
    try {
      await repository.assignDriver(busId, driverId, driverName);
      await refresh();
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> updateStatus(String busId, BusStatus status) async {
    try {
      await repository.updateStatus(busId, status);
      await refresh();
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> seedSampleData() async {
    try {
      await repository.seedSampleDataIfEmpty();
      await refresh();
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
  void search(String query) {
    if (query.trim().isEmpty) {
      emit(
        state.copyWith(
          filteredBuses: state.buses,
        ),
      );
      return;
    }

    final q = query.toLowerCase();

    final results = state.buses.where((bus) {
      return bus.vehicleNumber.toLowerCase().contains(q) ||
          bus.registration.toLowerCase().contains(q) ||
          bus.driver.toLowerCase().contains(q) ||
          bus.route.toLowerCase().contains(q);
    }).toList();

    emit(
      state.copyWith(
        filteredBuses: results,
      ),
    );
  }
  String currentFilter = "All";
  void filterByStatus(String status) {
    currentFilter = status;

    if (status == "All") {
      emit(
        state.copyWith(
          filteredBuses: state.buses,
        ),
      );

      return;
    }

    emit(
      state.copyWith(
        filteredBuses: state.buses
            .where((e) => e.status == status)
            .toList(),
      ),
    );
  }
}