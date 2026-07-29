import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/fleet_cubit.dart';
import '../models/bus_model.dart';

class StatusSelectorDialog extends StatelessWidget {
  final BusModel bus;

  const StatusSelectorDialog({
    super.key,
    required this.bus,
  });

  static const statuses = [
    "Running",
    "Boarding",
    "Offline",
    "Maintenance",
  ];

  Color color(String status) {
    switch (status) {
      case "Running":
        return Colors.green;
      case "Boarding":
        return Colors.orange;
      case "Offline":
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Status - ${bus.vehicleNumber}"),
      content: SizedBox(
        width: 350,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: statuses.map((status) {
            return ListTile(
              leading: CircleAvatar(
                radius: 8,
                backgroundColor: color(status),
              ),
              title: Text(status),
              trailing: bus.status == status
                  ? const Icon(Icons.check, color: Colors.green)
                  : null,
              onTap: () {
                context.read<FleetCubit>().updateStatus(
                  bus.id,
                  status,
                );

                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}