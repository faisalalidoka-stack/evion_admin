import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/bus_status.dart';
import '../../drivers/logic/driver_cubit.dart';
import '../logic/fleet_cubit.dart';
import '../models/bus_model.dart';

import 'assign_driver_dialog.dart';
import 'edit_bus_dialog.dart';
import 'delete_bus_dialog.dart';
import 'update_status_dialog.dart';

class FleetTable extends StatelessWidget {
  final List<BusModel> buses;

  const FleetTable({
    super.key,
    required this.buses,
  });

  Color statusColor(BusStatus status) {
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

  void _openStatusDialog(BuildContext context, BusModel bus) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<FleetCubit>(),
        child: UpdateStatusDialog(bus: bus),
      ),
    );
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
                DataCell(Text(bus.driverName)),
                DataCell(Text(bus.routeName)),
                DataCell(Text(bus.capacity.toString())),
                DataCell(
                  InkWell(
                    onTap: () => _openStatusDialog(context, bus),
                    child: Chip(
                      label: Text(bus.status.label),
                      avatar: CircleAvatar(
                        radius: 5,
                        backgroundColor: statusColor(bus.status),
                      ),
                      backgroundColor: statusColor(bus.status).withOpacity(.15),
                    ),
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        tooltip: "Update Status",
                        onPressed: () => _openStatusDialog(context, bus),
                        icon: const Icon(Icons.flag_outlined),
                      ),
                      IconButton(
                        tooltip: "Assign Driver",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => MultiBlocProvider(
                              providers: [
                                BlocProvider.value(
                                  value: context.read<FleetCubit>(),
                                ),
                                BlocProvider.value(
                                  value: context.read<DriverCubit>(),
                                ),
                              ],
                              child: AssignDriverDialog(bus: bus),
                            ),
                          );
                        },
                        icon: const Icon(Icons.person_add_alt),
                      ),
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
                              child: DeleteBusDialog(bus: bus),
                            ),
                          );
                        },
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
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