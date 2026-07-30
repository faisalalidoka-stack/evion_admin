import 'package:flutter/material.dart';

import '../../../core/widgets/admin_shell.dart';
import '../widgets/fleet_status_pie_chart.dart';
import '../widgets/reservation_status_pie_chart.dart';
import '../widgets/reservations_line_chart.dart';
import '../widgets/trips_bar_chart.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminShell(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Analytics",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: FleetStatusPieChart()),
                const SizedBox(width: 20),
                const Expanded(child: ReservationStatusPieChart()),
              ],
            ),
            const SizedBox(height: 20),
            const TripsBarChart(),
            const SizedBox(height: 20),
            const ReservationsLineChart(),
          ],
        ),
      ),
    );
  }
}