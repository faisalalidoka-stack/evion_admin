import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/config/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/fleet/data/fleet_repository.dart';
import 'features/fleet/logic/fleet_cubit.dart';

class EvionAdminApp extends StatelessWidget {
  const EvionAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FleetCubit(
            FleetRepository(),
          )..loadFleet(),
        ),
      ],
      child: MaterialApp.router(
        title: 'EViON Admin',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
