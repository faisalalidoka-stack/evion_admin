import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/trip_status.dart';
import '../logic/trip_cubit.dart';
import '../models/trip_model.dart';

class UpdateTripStatusDialog extends StatefulWidget {
  final TripModel trip;

  const UpdateTripStatusDialog({super.key, required this.trip});

  @override
  State<UpdateTripStatusDialog> createState() => _UpdateTripStatusDialogState();
}

class _UpdateTripStatusDialogState extends State<UpdateTripStatusDialog> {
  late TripStatus _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.trip.status;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Update Status — ${widget.trip.vehicleNumber}"),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: TripStatus.values.map((status) {
            return RadioListTile<TripStatus>(
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
            context.read<TripCubit>().updateStatus(widget.trip.id, _selected);

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "${widget.trip.vehicleNumber} status set to ${_selected.label}",
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