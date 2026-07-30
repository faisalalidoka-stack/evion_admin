import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/trip_cubit.dart';
import '../models/trip_model.dart';

class EditTripDialog extends StatefulWidget {
  final TripModel trip;

  const EditTripDialog({super.key, required this.trip});

  @override
  State<EditTripDialog> createState() => _EditTripDialogState();
}

class _EditTripDialogState extends State<EditTripDialog> {
  late DateTime _scheduledDate;
  late TimeOfDay _scheduledTime;

  @override
  void initState() {
    super.initState();
    _scheduledDate = widget.trip.scheduledAt;
    _scheduledTime = TimeOfDay.fromDateTime(widget.trip.scheduledAt);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _scheduledDate,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _scheduledDate = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _scheduledTime,
    );
    if (picked != null) setState(() => _scheduledTime = picked);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Reschedule — ${widget.trip.vehicleNumber}"),
      content: SizedBox(
        width: 420,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${widget.trip.driverName} · ${widget.trip.routeName}"),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_today, size: 18),
                    label: Text(
                      "${_scheduledDate.year}-${_scheduledDate.month.toString().padLeft(2, '0')}-${_scheduledDate.day.toString().padLeft(2, '0')}",
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickTime,
                    icon: const Icon(Icons.access_time, size: 18),
                    label: Text(_scheduledTime.format(context)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: () {
            final scheduledAt = DateTime(
              _scheduledDate.year,
              _scheduledDate.month,
              _scheduledDate.day,
              _scheduledTime.hour,
              _scheduledTime.minute,
            );

            context.read<TripCubit>().updateTrip(
              widget.trip.copyWith(
                scheduledAt: scheduledAt,
                updatedAt: DateTime.now(),
              ),
            );

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Trip rescheduled")),
            );
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}