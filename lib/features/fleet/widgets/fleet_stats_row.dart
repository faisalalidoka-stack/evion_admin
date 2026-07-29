import 'package:flutter/material.dart';

import '../../dashboards/widgets/summary_card.dart';
import '../logic/fleet_state.dart';

class FleetStatsRow extends StatelessWidget {
  final FleetState state;

  const FleetStatsRow({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final stats = [
      ('Total Buses', state.totalBuses, Icons.directions_bus, Colors.blueGrey),
      ('Active Buses', state.activeBusesCount, Icons.check_circle_outline, Colors.blue),
      ('Running', state.runningBusesCount, Icons.route, Colors.green),
      ('Maintenance', state.maintenanceBusesCount, Icons.build_outlined, Colors.amber),
      ('Offline', state.offlineBusesCount, Icons.power_off, Colors.red),
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: stats.map((s) {
        return SizedBox(
          width: 220,
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