import 'package:flutter/material.dart';

import '../../dashboards/widgets/summary_card.dart';
import '../logic/trip_state.dart';

class TripStatsRow extends StatelessWidget {
  final TripState state;

  const TripStatsRow({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final stats = [
      ('Total Trips', state.totalTrips, Icons.alt_route, Colors.blueGrey),
      ('Scheduled', state.scheduledCount, Icons.schedule, Colors.blue),
      ('In Progress', state.inProgressCount, Icons.directions_bus, Colors.green),
      ('Completed', state.completedCount, Icons.check_circle_outline, Colors.teal),
      ('Cancelled', state.cancelledCount, Icons.cancel_outlined, Colors.red),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: stats.map((s) {
        return SizedBox(
          width: 200,
          height: 110,
          child: SummaryCard(
            title: s.$1,
            value: s.$2.toString(),
            icon: s.$3,
            color: s.$4,
          ),
        );
      }).toList(),
    );
  }
}