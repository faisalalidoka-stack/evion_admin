import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/fleet_repository.dart';
import '../models/bus_model.dart';
import 'fleet_state.dart';

class FleetCubit extends Cubit<FleetState> {
  final FleetRepository repository;

  FleetCubit(this.repository) : super(const FleetState());

  void loadFleet() {
    emit(state.copyWith(loading: true));

    final buses = repository.getBuses();

    emit(
      state.copyWith(
        loading: false,
        buses: buses,
      ),
    );
  }

  void refresh() {
    emit(
      state.copyWith(
        buses: repository.getBuses(),
      ),
    );
  }

  void addBus(BusModel bus) {
    repository.addBus(bus);
    refresh();
  }

  void deleteBus(String id) {
    repository.deleteBus(id);
    refresh();
  }
  void updateBus(BusModel bus) {
    repository.updateBus(bus);
    refresh();
  }
  void assignDriver({
    required String busId,
    required String driverId,
    required String driverName,
  }) {
    repository.assignDriver(
      busId,
      driverId,
      driverName,
    );

    refresh();
  }
}