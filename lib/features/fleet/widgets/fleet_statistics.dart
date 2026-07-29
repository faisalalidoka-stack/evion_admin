import 'package:flutter/material.dart';

import '../models/bus_model.dart';

class FleetStatistics extends StatelessWidget {
  final List<BusModel> buses;

  const FleetStatistics({
    super.key,
    required this.buses,
  });

  int get running =>
      buses.where((e) => e.status == "Running").length;

  int get boarding =>
      buses.where((e) => e.status == "Boarding").length;

  int get offline =>
      buses.where((e) => e.status == "Offline").length;

  int get maintenance =>
      buses.where((e) => e.status == "Maintenance").length;

  Widget card(
      String title,
      int value,
      IconData icon,
      Color color,
      ) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Icon(
                icon,
                size: 34,
                color: color,
              ),
              const SizedBox(height: 10),
              Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        card(
          "Fleet",
          buses.length,
          Icons.directions_bus,
          Colors.blue,
        ),
        const SizedBox(width: 12),
        card(
          "Running",
          running,
          Icons.play_circle,
          Colors.green,
        ),
        const SizedBox(width: 12),
        card(
          "Boarding",
          boarding,
          Icons.people,
          Colors.orange,
        ),
        const SizedBox(width: 12),
        card(
          "Offline",
          offline,
          Icons.power_off,
          Colors.red,
        ),
        const SizedBox(width: 12),
        card(
          "Maintenance",
          maintenance,
          Icons.build,
          Colors.blueGrey,
        ),
      ],
    );
  }
}