import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/reservation_cubit.dart';
import '../models/reservation_model.dart';

class EditReservationDialog extends StatefulWidget {
  final ReservationModel reservation;

  const EditReservationDialog({super.key, required this.reservation});

  @override
  State<EditReservationDialog> createState() => _EditReservationDialogState();
}

class _EditReservationDialogState extends State<EditReservationDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController seatController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.reservation.passengerName);
    phoneController = TextEditingController(text: widget.reservation.passengerPhone);
    seatController =
        TextEditingController(text: widget.reservation.seatCount.toString());
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    seatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Reservation"),
      content: SizedBox(
        width: 460,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;

            context.read<ReservationCubit>().updateReservation(
              widget.reservation.copyWith(
                passengerName: nameController.text.trim(),
                passengerPhone: phoneController.text.trim(),
                seatCount: int.parse(seatController.text),
                updatedAt: DateTime.now(),
              ),
            );

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Reservation updated")),
            );
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}