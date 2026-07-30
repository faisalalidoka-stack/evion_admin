import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/trip_status.dart';
import '../../trips/logic/trip_cubit.dart';

class ActiveTripsTable extends StatelessWidget {
  const ActiveTripsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final activeTrips = context
        .watch<TripCubit>()
        .state
        .trips
        .where((t) => t.status == TripStatus.inProgress)
        .toList();

    if (activeTrips.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "No trips currently in progress.",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: DataTable(
          columns: const [
            DataColumn(label: Text("Bus")),
            DataColumn(label: Text("Driver")),
            DataColumn(label: Text("Route")),
            DataColumn(label: Text("Status")),
          ],
          rows: activeTrips.map((trip) {
            return DataRow(
              cells: [
                DataCell(Text(trip.vehicleNumber)),
                DataCell(Text(trip.driverName)),
                DataCell(Text(trip.routeName)),
                DataCell(
                  Chip(
                    label: Text(trip.status.label),
                    backgroundColor: Colors.green.shade100,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}