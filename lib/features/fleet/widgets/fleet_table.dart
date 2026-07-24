import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/fleet_cubit.dart';
import '../models/bus_model.dart';

class FleetTable extends StatelessWidget {
  final List<BusModel> buses;

  const FleetTable({
    super.key,
    required this.buses,
  });

  Color statusColor(String status) {
    switch (status) {
      case "Running":
        return Colors.green;
      case "Boarding":
        return Colors.orange;
      case "Offline":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text("Bus")),
            DataColumn(label: Text("Registration")),
            DataColumn(label: Text("Driver")),
            DataColumn(label: Text("Route")),
            DataColumn(label: Text("Capacity")),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Actions")),
          ],
          rows: buses.map((bus) {
            return DataRow(
              cells: [
                DataCell(Text(bus.vehicleNumber)),
                DataCell(Text(bus.registration)),
                DataCell(Text(bus.driver)),
                DataCell(Text(bus.route)),
                DataCell(Text(bus.capacity.toString())),
                DataCell(
                  Chip(
                    label: Text(bus.status),
                    backgroundColor:
                    statusColor(bus.status).withOpacity(.15),
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        tooltip: "Edit",
                        onPressed: () {
                          // Next batch
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        tooltip: "Delete",
                        onPressed: () {
                          context
                              .read<FleetCubit>()
                              .deleteBus(bus.id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}