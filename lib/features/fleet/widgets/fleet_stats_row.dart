import 'package:flutter/material.dart';

import '../../dashboards/widgets/summary_card.dart';
import '../logic/fleet_state.dart';

class FleetStatsRow extends StatelessWidget {
  final FleetState state;

  const FleetStatsRow({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 5,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.0,
      children: [
        SummaryCard(
          title: "Total Buses",
          value: state.totalBuses.toString(),
          icon: Icons.directions_bus,
          color: Colors.blueGrey,
        ),
        SummaryCard(
          title: "Active Buses",
          value: state.activeBusesCount.toString(),
          icon: Icons.check_circle_outline,
          color: Colors.blue,
        ),
        SummaryCard(
          title: "Running",
          value: state.runningBusesCount.toString(),
          icon: Icons.route,
          color: Colors.green,
        ),
        SummaryCard(
          title: "Maintenance",
          value: state.maintenanceBusesCount.toString(),
          icon: Icons.build_outlined,
          color: Colors.amber,
        ),
        SummaryCard(
          title: "Offline",
          value: state.offlineBusesCount.toString(),
          icon: Icons.power_off,
          color: Colors.red,
        ),
      ],
    );
  }
}