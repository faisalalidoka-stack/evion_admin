import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/fleet_cubit.dart';
import '../models/bus_model.dart';

class DeleteBusDialog extends StatelessWidget {
  final BusModel bus;

  const DeleteBusDialog({
    super.key,
    required this.bus,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.delete_forever,
        color: Colors.red,
        size: 42,
      ),
      title: const Text("Delete Bus"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Are you sure you want to delete this bus?",
          ),
          const SizedBox(height: 16),
          Text(
            bus.vehicleNumber,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(bus.registration),
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
          style: FilledButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          icon: const Icon(Icons.delete),
          label: const Text("Delete"),
          onPressed: () {
            context.read<FleetCubit>().deleteBus(bus.id);

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "${bus.vehicleNumber} deleted successfully",
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}