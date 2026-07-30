import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/route_repository.dart';
import '../models/route_model.dart';
import 'route_state.dart';

class RouteCubit extends Cubit<RouteState> {
  final RouteRepository repository;

  RouteCubit(this.repository) : super(const RouteState());

  StreamSubscription<List<RouteModel>>? _subscription;

  void loadRoutes() {
    _subscription?.cancel();

    emit(state.copyWith(loading: true));

    _subscription = repository.streamRoutes().listen((routes) {
      emit(state.copyWith(loading: false, routes: routes));
    }, onError: (e) {
      emit(state.copyWith(loading: false, errorMessage: e.toString()));
    });
  }

  Future<void> addRoute(RouteModel route) async {
    try {
      await repository.addRoute(route);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> updateRoute(RouteModel route) async {
    try {
      await repository.updateRoute(route);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> deleteRoute(String id) async {
    try {
      await repository.deleteRoute(id);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void setSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void setActiveFilter(bool? active) {
    emit(
      active == null
          ? state.copyWith(clearActiveFilter: true)
          : state.copyWith(activeFilter: active),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}