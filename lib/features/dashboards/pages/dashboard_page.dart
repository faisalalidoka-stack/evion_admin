import 'package:flutter/material.dart';

import '../../../core/widgets/admin_shell.dart';
import '../widgets/active_trips_table.dart';
import '../widgets/activity_panel.dart';
import '../widgets/dashboard_cards.dart';
import '../widgets/fleet_map_card.dart';


class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdminShell(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 24),

            DashboardCards(),

            SizedBox(height: 24),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: FleetMapCard(),
                ),

                SizedBox(width: 20),

                Expanded(
                  child: ActivityPanel(),
                ),
              ],
            ),

            SizedBox(height: 24),

            Text(
              "Active Trips",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 16),

            ActiveTripsTable(),
          ],
        ),
      ),
    );
  }
}