import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../reservations/logic/reservation_cubit.dart';
import '../../trips/logic/trip_cubit.dart';

class ActivityPanel extends StatelessWidget {
  const ActivityPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final trips = context.watch<TripCubit>().state.trips;
    final reservations = context.watch<ReservationCubit>().state.reservations;

    final events = <(DateTime, String, IconData, Color)>[
      ...trips.map(
            (t) => (
        t.updatedAt,
        "${t.vehicleNumber} trip ${t.status.label.toLowerCase()} · ${t.routeName}",
        Icons.directions_bus,
        Colors.blue,
        ),
      ),
      ...reservations.map(
            (r) => (
        r.updatedAt,
        "${r.passengerName} reservation ${r.status.label.toLowerCase()}",
        Icons.confirmation_number,
        Colors.orange,
        ),
      ),
    ]..sort((a, b) => b.$1.compareTo(a.$1));

    final recent = events.take(6).toList();
    final timeFormat = DateFormat('MMM d, h:mm a');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recent Activity",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (recent.isEmpty)
              const Text(
                "No activity yet.",
                style: TextStyle(color: Colors.grey),
              )
            else
              ...recent.map(
                    (event) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor: event.$4.withOpacity(.15),
                    child: Icon(event.$3, color: event.$4),
                  ),
                  title: Text(event.$2),
                  subtitle: Text(timeFormat.format(event.$1)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}