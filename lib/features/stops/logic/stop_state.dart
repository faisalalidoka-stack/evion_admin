import '../models/stop_model.dart';

class StopState {
  final List<StopModel> stops;
  final bool loading;
  final String searchQuery;
  final bool? activeFilter;
  final String? errorMessage;

  const StopState({
    this.stops = const [],
    this.loading = false,
    this.searchQuery = '',
    this.activeFilter,
    this.errorMessage,
  });

  List<StopModel> get filteredStops {
    final query = searchQuery.trim().toLowerCase();

    return stops.where((stop) {
      final matchesQuery = query.isEmpty ||
          stop.name.toLowerCase().contains(query) ||
          stop.address.toLowerCase().contains(query);

      final matchesActive = activeFilter == null || stop.active == activeFilter;

      return matchesQuery && matchesActive;
    }).toList();
  }

  int get totalStops => stops.length;
  int get activeStopsCount => stops.where((s) => s.active).length;

  StopState copyWith({
    List<StopModel>? stops,
    bool? loading,
    String? searchQuery,
    bool? activeFilter,
    bool clearActiveFilter = false,
    String? errorMessage,
    bool clearError = false,
  }) {
    return StopState(
      stops: stops ?? this.stops,
      loading: loading ?? this.loading,
      searchQuery: searchQuery ?? this.searchQuery,
      activeFilter:
      clearActiveFilter ? null : (activeFilter ?? this.activeFilter),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}