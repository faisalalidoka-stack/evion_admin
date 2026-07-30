import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../reservations/logic/reservation_cubit.dart';

class ReservationStatusPieChart extends StatelessWidget {
  const ReservationStatusPieChart({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ReservationCubit>().state;

    final data = [
      ('Confirmed', state.confirmedCount, Colors.blue),
      ('Completed', state.completedCount, Colors.teal),
      ('Cancelled', state.cancelledCount, Colors.red),
    ];

    final total = state.totalReservations;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Reservation Status",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: total == 0
                  ? const Center(
                child: Text("No reservations yet", style: TextStyle(color: Colors.grey)),
              )
                  : Row(
                children: [
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: data
                            .where((d) => d.$2 > 0)
                            .map(
                              (d) => PieChartSectionData(
                            value: d.$2.toDouble(),
                            title: d.$2.toString(),
                            color: d.$3,
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
                    children: data.map((d) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Row(
                          children: [
                            Container(width: 10, height: 10, color: d.$3),
                            const SizedBox(width: 6),
                            Text("${d.$1} (${d.$2})", style: const TextStyle(fontSize: 12)),
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