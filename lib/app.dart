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

class EvionAdminApp extends StatelessWidget {
  const EvionAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = AuthCubit(AuthRepository());
    final fleetCubit = FleetCubit(FleetRepository())..loadFleet();
    final driverCubit = DriverCubit(DriverRepository())..loadDrivers();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authCubit),
        BlocProvider.value(value: fleetCubit),
        BlocProvider.value(value: driverCubit),
        BlocProvider(
          create: (_) =>
          DriverCubit(
            DriverRepository(),
          )..loadDrivers(),
        ),
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