import 'package:flutter/material.dart';

import '../../dashboards/widgets/summary_card.dart';
import '../logic/reservation_state.dart';

class ReservationStatsRow extends StatelessWidget {
  final ReservationState state;

  const ReservationStatsRow({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final stats = [
      ('Total Reservations', state.totalReservations, Icons.confirmation_number, Colors.blueGrey),
      ('Confirmed', state.confirmedCount, Icons.check_circle_outline, Colors.blue),
      ('Completed', state.completedCount, Icons.task_alt, Colors.teal),
      ('Cancelled', state.cancelledCount, Icons.cancel_outlined, Colors.red),
      ('Seats Booked', state.totalSeatsBooked, Icons.event_seat, Colors.green),
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