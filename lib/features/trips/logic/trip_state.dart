import '../../../core/constants/trip_status.dart';
import '../models/trip_model.dart';

class TripState {
  final List<TripModel> trips;
  final bool loading;
  final String searchQuery;
  final TripStatus? statusFilter;
  final String? errorMessage;

  const TripState({
    this.trips = const [],
    this.loading = false,
    this.searchQuery = '',
    this.statusFilter,
    this.errorMessage,
  });

  List<TripModel> get filteredTrips {
    final query = searchQuery.trim().toLowerCase();

    return trips.where((trip) {
      final matchesQuery = query.isEmpty ||
          trip.vehicleNumber.toLowerCase().contains(query) ||
          trip.driverName.toLowerCase().contains(query) ||
          trip.routeName.toLowerCase().contains(query);

      final matchesStatus = statusFilter == null || trip.status == statusFilter;

      return matchesQuery && matchesStatus;
    }).toList();
  }

  int get totalTrips => trips.length;
  int get scheduledCount =>
      trips.where((t) => t.status == TripStatus.scheduled).length;
  int get inProgressCount =>
      trips.where((t) => t.status == TripStatus.inProgress).length;
  int get completedCount =>
      trips.where((t) => t.status == TripStatus.completed).length;
  int get cancelledCount =>
      trips.where((t) => t.status == TripStatus.cancelled).length;

  TripState copyWith({
    List<TripModel>? trips,
    bool? loading,
    String? searchQuery,
    TripStatus? statusFilter,
    bool clearStatusFilter = false,
    String? errorMessage,
    bool clearError = false,
  }) {
    return TripState(
      trips: trips ?? this.trips,
      loading: loading ?? this.loading,
      searchQuery: searchQuery ?? this.searchQuery,
      statusFilter:
      clearStatusFilter ? null : (statusFilter ?? this.statusFilter),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}