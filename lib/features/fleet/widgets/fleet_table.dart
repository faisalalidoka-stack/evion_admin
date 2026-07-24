import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/fleet_cubit.dart';
import '../models/bus_model.dart';

import 'edit_bus_dialog.dart';
import 'delete_bus_dialog.dart';

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
                          showDialog(
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: context.read<FleetCubit>(),
                              child: EditBusDialog(bus: bus),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        tooltip: "Delete",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: context.read<FleetCubit>(),
                              child: DeleteBusDialog(
                                bus: bus,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.delete_outline,
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