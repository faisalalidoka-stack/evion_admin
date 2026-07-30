import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/reservation_cubit.dart';
import '../models/reservation_model.dart';

class DeleteReservationDialog extends StatelessWidget {
  final ReservationModel reservation;

  const DeleteReservationDialog({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.delete_forever, color: Colors.red, size: 42),
      title: const Text("Delete Reservation"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Are you sure you want to delete this reservation?"),
          const SizedBox(height: 16),
          Text(
            reservation.passengerName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text("${reservation.vehicleNumber} · ${reservation.routeName}"),
          const SizedBox(height: 8),
          const Text(
            "This action cannot be undone.",
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: Colors.red),
          icon: const Icon(Icons.delete),
          label: const Text("Delete"),
          onPressed: () {
            context.read<ReservationCubit>().deleteReservation(reservation.id);

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Reservation for ${reservation.passengerName} deleted")),
            );
          },
        ),
      ],
    );
  }
}