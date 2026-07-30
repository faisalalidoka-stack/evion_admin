import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../drivers/logic/driver_cubit.dart';
import '../../drivers/logic/driver_state.dart';
import '../../fleet/logic/fleet_cubit.dart';
import '../../fleet/logic/fleet_state.dart';
import '../../reservations/logic/reservation_cubit.dart';
import '../../reservations/logic/reservation_state.dart';
import '../../trips/logic/trip_cubit.dart';
import '../../trips/logic/trip_state.dart';
import 'summary_card.dart';

class DashboardCards extends StatelessWidget {
  const DashboardCards({super.key});

  @override
  Widget build(BuildContext context) {
    final fleetState = context.watch<FleetCubit>().state;
    final driverState = context.watch<DriverCubit>().state;
    final tripState = context.watch<TripCubit>().state;
    final reservationState = context.watch<ReservationCubit>().state;

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 2.4,
      children: [
        SummaryCard(
          title: "Fleet",
          value: fleetState.totalBuses.toString(),
          icon: Icons.directions_bus,
          color: Colors.blue,
        ),
        SummaryCard(
          title: "Active Drivers",
          value: driverState.drivers.where((d) => d.active).length.toString(),
          icon: Icons.people,
          color: Colors.green,
        ),
        SummaryCard(
          title: "Active Trips",
          value: tripState.inProgressCount.toString(),
          icon: Icons.route,
          color: Colors.orange,
        ),
        SummaryCard(
          title: "Reservations",
          value: reservationState.totalReservations.toString(),
          icon: Icons.confirmation_number,
          color: Colors.purple,
        ),
      ],
    );
  }
}