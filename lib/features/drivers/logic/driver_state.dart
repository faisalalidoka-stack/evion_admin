import '../models/driver_model.dart';

class DriverState {
  final bool loading;
  final List<DriverModel> drivers;
  final List<DriverModel> filteredDrivers;

  const DriverState({
    this.loading = false,
    this.drivers = const [],
    this.filteredDrivers = const [],
  });

  DriverState copyWith({
    bool? loading,
    List<DriverModel>? drivers,
    List<DriverModel>? filteredDrivers,
  }) {
    return DriverState(
      loading: loading ?? this.loading,
      drivers: drivers ?? this.drivers,
      filteredDrivers: filteredDrivers ?? this.filteredDrivers,
    );
  }
}