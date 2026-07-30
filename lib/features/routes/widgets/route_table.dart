import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/route_cubit.dart';
import '../models/route_model.dart';
import 'edit_route_dialog.dart';
import 'delete_route_dialog.dart';

class RouteTable extends StatelessWidget {
  final List<RouteModel> routes;

  const RouteTable({super.key, required this.routes});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Code")),
            DataColumn(label: Text("Stops")),
            DataColumn(label: Text("Distance")),
            DataColumn(label: Text("Duration")),
            DataColumn(label: Text("Active")),
            DataColumn(label: Text("Actions")),
          ],
          rows: routes.map((route) {
            return DataRow(
              cells: [
                DataCell(Text(route.name)),
                DataCell(Text(route.code)),
                DataCell(Text("${route.stopIds.length}")),
                DataCell(Text("${route.distanceKm.toStringAsFixed(1)} km")),
                DataCell(Text("${route.estimatedDurationMinutes} min")),
                DataCell(
                  Icon(
                    route.active ? Icons.check_circle : Icons.cancel,
                    color: route.active ? Colors.green : Colors.red,
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
                              value: context.read<RouteCubit>(),
                              child: EditRouteDialog(route: route),
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
                              value: context.read<RouteCubit>(),
                              child: DeleteRouteDialog(route: route),
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