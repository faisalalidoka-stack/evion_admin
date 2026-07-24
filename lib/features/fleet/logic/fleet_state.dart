import '../models/bus_model.dart';

class FleetState {
  final List<BusModel> buses;
  final bool loading;

  const FleetState({
    this.buses = const [],
    this.loading = false,
  });

  FleetState copyWith({
    List<BusModel>? buses,
    bool? loading,
  }) {
    return FleetState(
      buses: buses ?? this.buses,
      loading: loading ?? this.loading,
    );
  }
}