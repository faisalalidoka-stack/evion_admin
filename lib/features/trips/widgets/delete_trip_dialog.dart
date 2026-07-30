import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/trip_cubit.dart';
import '../models/trip_model.dart';

class DeleteTripDialog extends StatelessWidget {
  final TripModel trip;

  const DeleteTripDialog({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.delete_forever, color: Colors.red, size: 42),
      title: const Text("Delete Trip"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Are you sure you want to delete this trip?"),
          const SizedBox(height: 16),
          Text(
            "${trip.vehicleNumber} · ${trip.routeName}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(trip.driverName),
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
            context.read<TripCubit>().deleteTrip(trip.id);

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Trip for ${trip.vehicleNumber} deleted")),
            );
          },
        ),
      ],
    );
  }
}