import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/fleet_cubit.dart';
import '../models/bus_model.dart';

class UpdateStatusDialog extends StatefulWidget {
  final BusModel bus;

  const UpdateStatusDialog({super.key, required this.bus});

  @override
  State<UpdateStatusDialog> createState() => _UpdateStatusDialogState();
}

class _UpdateStatusDialogState extends State<UpdateStatusDialog> {
  late BusStatus _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.bus.status;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Update Status — ${widget.bus.vehicleNumber}"),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: BusStatus.values.map((status) {
            return RadioListTile<BusStatus>(
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
            context.read<FleetCubit>().updateStatus(widget.bus.id, _selected);

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "${widget.bus.vehicleNumber} status set to ${_selected.label}",
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