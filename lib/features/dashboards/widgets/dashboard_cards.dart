import 'package:flutter/material.dart';

import 'summary_card.dart';

class DashboardCards extends StatelessWidget {
  const DashboardCards({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 2.4,
      children: const [
        SummaryCard(
          title: "Fleet",
          value: "48",
          icon: Icons.directions_bus,
          color: Colors.blue,
        ),
        SummaryCard(
          title: "Drivers Online",
          value: "31",
          icon: Icons.people,
          color: Colors.green,
        ),
        SummaryCard(
          title: "Active Trips",
          value: "14",
          icon: Icons.route,
          color: Colors.orange,
        ),
        SummaryCard(
          title: "Reservations",
          value: "286",
          icon: Icons.confirmation_number,
          color: Colors.purple,
        ),
      ],
    );
  }
}