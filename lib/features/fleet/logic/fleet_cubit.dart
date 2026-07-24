import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/fleet_repository.dart';
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

  void deleteBus(String id) {
    repository.deleteBus(id);
    refresh();
  }
}