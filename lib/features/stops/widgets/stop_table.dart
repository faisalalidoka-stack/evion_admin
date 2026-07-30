import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/stop_cubit.dart';
import '../models/stop_model.dart';
import 'edit_stop_dialog.dart';
import 'delete_stop_dialog.dart';

class StopTable extends StatelessWidget {
  final List<StopModel> stops;

  const StopTable({super.key, required this.stops});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Address")),
            DataColumn(label: Text("Latitude")),
            DataColumn(label: Text("Longitude")),
            DataColumn(label: Text("Active")),
            DataColumn(label: Text("Actions")),
          ],
          rows: stops.map((stop) {
            return DataRow(
              cells: [
                DataCell(Text(stop.name)),
                DataCell(Text(stop.address)),
                DataCell(Text(stop.latitude.toStringAsFixed(5))),
                DataCell(Text(stop.longitude.toStringAsFixed(5))),
                DataCell(
                  Icon(
                    stop.active ? Icons.check_circle : Icons.cancel,
                    color: stop.active ? Colors.green : Colors.red,
                    size: 20,
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
                              value: context.read<StopCubit>(),
                              child: EditStopDialog(stop: stop),
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
                              value: context.read<StopCubit>(),
                              child: DeleteStopDialog(stop: stop),
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