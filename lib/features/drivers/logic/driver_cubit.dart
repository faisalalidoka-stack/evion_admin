import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/driver_repository.dart';
import '../models/driver_model.dart';
import 'driver_state.dart';

class DriverCubit extends Cubit<DriverState> {
  DriverCubit(this.repository) : super(const DriverState());

  final DriverRepository repository;

  StreamSubscription<List<DriverModel>>? _subscription;

  void loadDrivers() {
    emit(state.copyWith(loading: true));

    _subscription?.cancel();

    _subscription = repository.streamDrivers().listen((drivers) {
      emit(
        state.copyWith(
          loading: false,
          drivers: drivers,
          filteredDrivers: drivers,
        ),
      );
    });
  }

  Future<void> addDriver(DriverModel driver) {
    return repository.addDriver(driver);
  }

  Future<void> updateDriver(DriverModel driver) {
    return repository.updateDriver(driver);
  }

  Future<void> deleteDriver(String id) {
    return repository.deleteDriver(id);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
  void search(String query) {
    if (query.trim().isEmpty) {
      emit(
        state.copyWith(
          filteredDrivers: state.drivers,
        ),
      );
      return;
    }

    final q = query.toLowerCase();

    emit(
      state.copyWith(
        filteredDrivers: state.drivers.where((driver) {
          return driver.fullName.toLowerCase().contains(q) ||
              driver.employeeId.toLowerCase().contains(q) ||
              driver.phone.toLowerCase().contains(q) ||
              driver.email.toLowerCase().contains(q);
        }).toList(),
      ),
    );
  }
}