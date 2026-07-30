import '../../../core/constants/reservation_status.dart';
import '../models/reservation_model.dart';

class ReservationState {
  final List<ReservationModel> reservations;
  final bool loading;
  final String searchQuery;
  final ReservationStatus? statusFilter;
  final String? errorMessage;

  const ReservationState({
    this.reservations = const [],
    this.loading = false,
    this.searchQuery = '',
    this.statusFilter,
    this.errorMessage,
  });

  List<ReservationModel> get filteredReservations {
    final query = searchQuery.trim().toLowerCase();

    return reservations.where((r) {
      final matchesQuery = query.isEmpty ||
          r.passengerName.toLowerCase().contains(query) ||
          r.passengerPhone.toLowerCase().contains(query) ||
          r.vehicleNumber.toLowerCase().contains(query) ||
          r.routeName.toLowerCase().contains(query);

      final matchesStatus = statusFilter == null || r.status == statusFilter;

      return matchesQuery && matchesStatus;
    }).toList();
  }

  int get totalReservations => reservations.length;
  int get confirmedCount =>
      reservations.where((r) => r.status == ReservationStatus.confirmed).length;
  int get cancelledCount =>
      reservations.where((r) => r.status == ReservationStatus.cancelled).length;
  int get completedCount =>
      reservations.where((r) => r.status == ReservationStatus.completed).length;
  int get totalSeatsBooked =>
      reservations.where((r) => r.status != ReservationStatus.cancelled)
          .fold(0, (sum, r) => sum + r.seatCount);

  ReservationState copyWith({
    List<ReservationModel>? reservations,
    bool? loading,
    String? searchQuery,
    ReservationStatus? statusFilter,
    bool clearStatusFilter = false,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ReservationState(
      reservations: reservations ?? this.reservations,
      loading: loading ?? this.loading,
      searchQuery: searchQuery ?? this.searchQuery,
      statusFilter:
      clearStatusFilter ? null : (statusFilter ?? this.statusFilter),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}