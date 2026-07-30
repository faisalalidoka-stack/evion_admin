import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/reservation_status.dart';
import '../logic/reservation_cubit.dart';
import '../models/reservation_model.dart';
import 'edit_reservation_dialog.dart';
import 'delete_reservation_dialog.dart';
import 'update_reservation_status_dialog.dart';

class ReservationTable extends StatelessWidget {
  final List<ReservationModel> reservations;

  const ReservationTable({super.key, required this.reservations});

  Color statusColor(ReservationStatus status) {
    switch (status) {
      case ReservationStatus.confirmed:
        return Colors.blue;
      case ReservationStatus.completed:
        return Colors.teal;
      case ReservationStatus.cancelled:
        return Colors.red;
    }
  }

  void _openStatusDialog(BuildContext context, ReservationModel reservation) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<ReservationCubit>(),
        child: UpdateReservationStatusDialog(reservation: reservation),
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
            DataColumn(label: Text("Passenger")),
            DataColumn(label: Text("Phone")),
            DataColumn(label: Text("Bus")),
            DataColumn(label: Text("Route")),
            DataColumn(label: Text("Trip Time")),
            DataColumn(label: Text("Seats")),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Actions")),
          ],
          rows: reservations.map((r) {
            return DataRow(
              cells: [
                DataCell(Text(r.passengerName)),
                DataCell(Text(r.passengerPhone)),
                DataCell(Text(r.vehicleNumber)),
                DataCell(Text(r.routeName)),
                DataCell(Text(dateFormat.format(r.scheduledAt))),
                DataCell(Text(r.seatCount.toString())),
                DataCell(
                  InkWell(
                    onTap: () => _openStatusDialog(context, r),
                    child: Chip(
                      label: Text(r.status.label),
                      avatar: CircleAvatar(
                        radius: 5,
                        backgroundColor: statusColor(r.status),
                      ),
                      backgroundColor: statusColor(r.status).withOpacity(.15),
                    ),
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        tooltip: "Update Status",
                        onPressed: () => _openStatusDialog(context, r),
                        icon: const Icon(Icons.flag_outlined),
                      ),
                      IconButton(
                        tooltip: "Edit",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: context.read<ReservationCubit>(),
                              child: EditReservationDialog(reservation: r),
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
                              value: context.read<ReservationCubit>(),
                              child: DeleteReservationDialog(reservation: r),
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