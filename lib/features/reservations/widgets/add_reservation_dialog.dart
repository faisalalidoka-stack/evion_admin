import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/trip_status.dart';
import '../../trips/logic/trip_cubit.dart';
import '../logic/reservation_cubit.dart';
import '../models/reservation_model.dart';

class AddReservationDialog extends StatefulWidget {
  const AddReservationDialog({super.key});

  @override
  State<AddReservationDialog> createState() => _AddReservationDialogState();
}

class _AddReservationDialogState extends State<AddReservationDialog> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final seatController = TextEditingController(text: "1");

  String? _tripId;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    seatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tripState = context.watch<TripCubit>().state;
    final dateFormat = DateFormat('MMM d, y · h:mm a');

    final bookableTrips = tripState.trips
        .where((t) =>
    t.status == TripStatus.scheduled ||
        t.status == TripStatus.inProgress)
        .toList();

    return AlertDialog(
      title: const Text("Add Reservation"),
      content: SizedBox(
        width: 480,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: _tripId,
                  decoration: const InputDecoration(labelText: "Trip"),
                  items: bookableTrips
                      .map((t) => DropdownMenuItem(
                    value: t.id,
                    child: Text(
                      "${t.vehicleNumber} · ${t.routeName} — ${dateFormat.format(t.scheduledAt)}",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
                      .toList(),
                  onChanged: (v) => setState(() => _tripId = v),
                  validator: (v) => v == null ? "Required" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Passenger Name"),
                  validator: (v) =>
                  v == null || v.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: "Phone Number"),
                  validator: (v) =>
                  v == null || v.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: seatController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Seats"),
                  validator: (v) {
                    if (v == null || v.isEmpty) return "Required";
                    final n = int.tryParse(v);
                    if (n == null || n < 1) return "Invalid";
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;

            final trip = tripState.trips.firstWhere((t) => t.id == _tripId);
            final now = DateTime.now();

            context.read<ReservationCubit>().addReservation(
              ReservationModel(
                id: now.millisecondsSinceEpoch.toString(),
                tripId: trip.id,
                vehicleNumber: trip.vehicleNumber,
                driverName: trip.driverName,
                routeName: trip.routeName,
                scheduledAt: trip.scheduledAt,
                passengerName: nameController.text.trim(),
                passengerPhone: phoneController.text.trim(),
                seatCount: int.parse(seatController.text),
                createdAt: now,
                updatedAt: now,
              ),
            );

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Reservation added successfully")),
            );
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}