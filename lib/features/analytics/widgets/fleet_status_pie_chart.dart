import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../core/constants/bus_status.dart';
import '../../fleet/logic/fleet_cubit.dart';

class FleetStatusPieChart extends StatelessWidget {
  const FleetStatusPieChart({super.key});

  Color _colorFor(BusStatus status) {
    switch (status) {
      case BusStatus.running:
        return Colors.green;
      case BusStatus.boarding:
        return Colors.orange;
      case BusStatus.available:
        return Colors.blue;
      case BusStatus.maintenance:
        return Colors.amber;
      case BusStatus.offline:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final buses = context.watch<FleetCubit>().state.buses;

    final counts = {
      for (final status in BusStatus.values)
        status: buses.where((b) => b.status == status).length,
    };

    final total = buses.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Fleet Status",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: total == 0
                  ? const Center(
                child: Text("No buses yet", style: TextStyle(color: Colors.grey)),
              )
                  : Row(
                children: [
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: BusStatus.values
                            .where((s) => counts[s]! > 0)
                            .map(
                              (status) => PieChartSectionData(
                            value: counts[status]!.toDouble(),
                            title: counts[status].toString(),
                            color: _colorFor(status),
                            radius: 60,
                            titleStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                            .toList(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: BusStatus.values.map((status) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              color: _colorFor(status),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "${status.label} (${counts[status]})",
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}