import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/stop_repository.dart';
import '../models/stop_model.dart';
import 'stop_state.dart';

class StopCubit extends Cubit<StopState> {
  final StopRepository repository;

  StopCubit(this.repository) : super(const StopState());

  StreamSubscription<List<StopModel>>? _subscription;

  void loadStops() {
    _subscription?.cancel();

    emit(state.copyWith(loading: true));

    _subscription = repository.streamStops().listen((stops) {
      emit(state.copyWith(loading: false, stops: stops));
    }, onError: (e) {
      emit(state.copyWith(loading: false, errorMessage: e.toString()));
    });
  }

  Future<void> addStop(StopModel stop) async {
    try {
      await repository.addStop(stop);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> updateStop(StopModel stop) async {
    try {
      await repository.updateStop(stop);
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> deleteStop(String id) async {
    try {
      await repository.deleteStop(id);
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