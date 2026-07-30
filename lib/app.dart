import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/config/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/authentication/data/auth_repository.dart';
import 'features/authentication/logic/auth_cubit.dart';
import 'features/drivers/data/driver_repository.dart';
import 'features/drivers/logic/driver_cubit.dart';
import 'features/fleet/data/fleet_repository.dart';
import 'features/fleet/logic/fleet_cubit.dart';
import 'features/reservations/data/reservation_repository.dart';
import 'features/reservations/logic/reservation_cubit.dart';
import 'features/routes/data/route_repository.dart';
import 'features/routes/logic/route_cubit.dart';
import 'features/stops/data/stop_repository.dart';
import 'features/stops/logic/stop_cubit.dart';
import 'features/trips/data/trip_repository.dart';
import 'features/trips/logic/trip_cubit.dart';

class EvionAdminApp extends StatelessWidget {
  const EvionAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit(AuthRepository());
    final fleetCubit = FleetCubit(FleetRepository())..loadFleet();
    final driverCubit = DriverCubit(DriverRepository())..loadDrivers();
    final stopCubit = StopCubit(StopRepository())..loadStops();
    final routeCubit = RouteCubit(RouteRepository())..loadRoutes();
    final tripCubit = TripCubit(TripRepository())..loadTrips();
    final reservationCubit =
    ReservationCubit(ReservationRepository())..loadReservations();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authCubit),
        BlocProvider.value(value: fleetCubit),
        BlocProvider.value(value: driverCubit),
        BlocProvider.value(value: stopCubit),
        BlocProvider.value(value: routeCubit),
        BlocProvider.value(value: tripCubit),
        BlocProvider.value(value: reservationCubit),
      ],
      child: MaterialApp.router(
        title: 'EViON Admin',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.build(authCubit),
      ),
    );
  }
}