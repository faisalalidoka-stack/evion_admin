import '../models/route_model.dart';

class RouteState {
  final List<RouteModel> routes;
  final bool loading;
  final String searchQuery;
  final bool? activeFilter;
  final String? errorMessage;

  const RouteState({
    this.routes = const [],
    this.loading = false,
    this.searchQuery = '',
    this.activeFilter,
    this.errorMessage,
  });

  List<RouteModel> get filteredRoutes {
    final query = searchQuery.trim().toLowerCase();

    return routes.where((route) {
      final matchesQuery = query.isEmpty ||
          route.name.toLowerCase().contains(query) ||
          route.code.toLowerCase().contains(query);

      final matchesActive = activeFilter == null || route.active == activeFilter;

      return matchesQuery && matchesActive;
    }).toList();
  }

  int get totalRoutes => routes.length;
  int get activeRoutesCount => routes.where((r) => r.active).length;

  RouteState copyWith({
    List<RouteModel>? routes,
    bool? loading,
    String? searchQuery,
    bool? activeFilter,
    bool clearActiveFilter = false,
    String? errorMessage,
    bool clearError = false,
  }) {
    return RouteState(
      routes: routes ?? this.routes,
      loading: loading ?? this.loading,
      searchQuery: searchQuery ?? this.searchQuery,
      activeFilter:
      clearActiveFilter ? null : (activeFilter ?? this.activeFilter),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}