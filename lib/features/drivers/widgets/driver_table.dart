import 'package:flutter/material.dart';

import '../models/driver_model.dart';
import 'edit_driver_dialog.dart';
import 'delete_driver_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/driver_cubit.dart';

class DriverTable extends StatelessWidget {
  final List<DriverModel> drivers;

  const DriverTable({
    super.key,
    required this.drivers,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text("Employee ID")),
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Phone")),
            DataColumn(label: Text("Email")),
            DataColumn(label: Text("Bus")),
            DataColumn(label: Text("Online")),
            DataColumn(label: Text("Actions")),
          ],
          rows: drivers.map((driver) {
            return DataRow(
              cells: [
                DataCell(Text(driver.employeeId)),
                DataCell(Text(driver.fullName)),
                DataCell(Text(driver.phone)),
                DataCell(Text(driver.email)),
                DataCell(Text(driver.assignedBusId.isEmpty
                    ? "-"
                    : driver.assignedBusId)),
                DataCell(
                  Chip(
                    label: Text(
                      driver.online ? "Online" : "Offline",
                    ),
                    backgroundColor: driver.online
                        ? Colors.green.withOpacity(.15)
                        : Colors.red.withOpacity(.15),
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: context.read<DriverCubit>(),
                              child: EditDriverDialog(
                                driver: driver,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: context.read<DriverCubit>(),
                              child: DeleteDriverDialog(
                                driver: driver,
                              ),
                            ),
                          );
                        },
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