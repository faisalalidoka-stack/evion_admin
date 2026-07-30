import '../models/bus_model.dart';
import '../../../core/constants/bus_status.dart';

class FleetState {
  final List<BusModel> buses;
  final bool loading;
  final String searchQuery;
  final BusStatus? statusFilter;
  final bool? activeFilter;
  final String? errorMessage;

  const FleetState({
    this.buses = const [],
    this.loading = false,
    this.searchQuery = '',
    this.statusFilter,
    this.activeFilter,
    this.errorMessage,
  });

  List<BusModel> get filteredBuses {
    final query = searchQuery.trim().toLowerCase();

    return buses.where((bus) {
      final matchesQuery = query.isEmpty ||
          bus.vehicleNumber.toLowerCase().contains(query) ||
          bus.registration.toLowerCase().contains(query) ||
          bus.driverName.toLowerCase().contains(query) ||
          bus.routeName.toLowerCase().contains(query);

      final matchesStatus =
          statusFilter == null || bus.status == statusFilter;

      final matchesActive =
          activeFilter == null || bus.active == activeFilter;

      return matchesQuery && matchesStatus && matchesActive;
    }).toList();
  }

  int get totalBuses => buses.length;
  int get activeBusesCount => buses.where((b) => b.active).length;
  int get runningBusesCount =>
      buses.where((b) => b.status == BusStatus.running).length;
  int get maintenanceBusesCount =>
      buses.where((b) => b.status == BusStatus.maintenance).length;
  int get offlineBusesCount =>
      buses.where((b) => b.status == BusStatus.offline).length;

  FleetState copyWith({
    List<BusModel>? buses,
    bool? loading,
    String? searchQuery,
    BusStatus? statusFilter,
    bool clearStatusFilter = false,
    bool? activeFilter,
    bool clearActiveFilter = false,
    String? errorMessage,
    bool clearError = false,
  }) {
    return FleetState(
      buses: buses ?? this.buses,
      loading: loading ?? this.loading,
      searchQuery: searchQuery ?? this.searchQuery,
      statusFilter:
      clearStatusFilter ? null : (statusFilter ?? this.statusFilter),
      activeFilter:
      clearActiveFilter ? null : (activeFilter ?? this.activeFilter),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}