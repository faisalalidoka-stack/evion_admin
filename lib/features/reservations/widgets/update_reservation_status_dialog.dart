import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/reservation_status.dart';
import '../logic/reservation_cubit.dart';
import '../models/reservation_model.dart';

class UpdateReservationStatusDialog extends StatefulWidget {
  final ReservationModel reservation;

  const UpdateReservationStatusDialog({super.key, required this.reservation});

  @override
  State<UpdateReservationStatusDialog> createState() =>
      _UpdateReservationStatusDialogState();
}

class _UpdateReservationStatusDialogState
    extends State<UpdateReservationStatusDialog> {
  late ReservationStatus _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.reservation.status;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Update Status — ${widget.reservation.passengerName}"),
      content: SizedBox(
        width: 340,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: ReservationStatus.values.map((status) {
            return RadioListTile<ReservationStatus>(
              title: Text(status.label),
              value: status,
              groupValue: _selected,
              onChanged: (value) {
                if (value != null) setState(() => _selected = value);
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: () {
            context
                .read<ReservationCubit>()
                .updateStatus(widget.reservation.id, _selected);

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "${widget.reservation.passengerName} status set to ${_selected.label}",
                ),
              ),
            );
          },
          child: const Text("Update"),
        ),
      ],
    );
  }
}