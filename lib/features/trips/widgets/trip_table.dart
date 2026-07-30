import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/trip_status.dart';
import '../logic/trip_cubit.dart';
import '../models/trip_model.dart';
import 'edit_trip_dialog.dart';
import 'delete_trip_dialog.dart';
import 'update_trip_status_dialog.dart';

class TripTable extends StatelessWidget {
  final List<TripModel> trips;

  const TripTable({super.key, required this.trips});

  Color statusColor(TripStatus status) {
    switch (status) {
      case TripStatus.scheduled:
        return Colors.blue;
      case TripStatus.inProgress:
        return Colors.green;
      case TripStatus.completed:
        return Colors.teal;
      case TripStatus.cancelled:
        return Colors.red;
    }
  }

  void _openStatusDialog(BuildContext context, TripModel trip) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<TripCubit>(),
        child: UpdateTripStatusDialog(trip: trip),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, y · h:mm a');

    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text("Bus")),
            DataColumn(label: Text("Driver")),
            DataColumn(label: Text("Route")),
            DataColumn(label: Text("Scheduled")),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Actions")),
          ],
          rows: trips.map((trip) {
            return DataRow(
              cells: [
                DataCell(Text(trip.vehicleNumber)),
                DataCell(Text(trip.driverName)),
                DataCell(Text(trip.routeName)),
                DataCell(Text(dateFormat.format(trip.scheduledAt))),
                DataCell(
                  InkWell(
                    onTap: () => _openStatusDialog(context, trip),
                    child: Chip(
                      label: Text(trip.status.label),
                      avatar: CircleAvatar(
                        radius: 5,
                        backgroundColor: statusColor(trip.status),
                      ),
                      backgroundColor: statusColor(trip.status).withOpacity(.15),
                    ),
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        tooltip: "Update Status",
                        onPressed: () => _openStatusDialog(context, trip),
                        icon: const Icon(Icons.flag_outlined),
                      ),
                      IconButton(
                        tooltip: "Reschedule",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: context.read<TripCubit>(),
                              child: EditTripDialog(trip: trip),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit_calendar),
                      ),
                      IconButton(
                        tooltip: "Delete",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: context.read<TripCubit>(),
                              child: DeleteTripDialog(trip: trip),
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