import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../drivers/logic/driver_cubit.dart';
import '../../drivers/logic/driver_state.dart';
import '../../fleet/logic/fleet_cubit.dart';
import '../../fleet/logic/fleet_state.dart';
import '../../routes/logic/route_cubit.dart';
import '../../routes/logic/route_state.dart';
import '../logic/trip_cubit.dart';
import '../models/trip_model.dart';

class AddTripDialog extends StatefulWidget {
  const AddTripDialog({super.key});

  @override
  State<AddTripDialog> createState() => _AddTripDialogState();
}

class _AddTripDialogState extends State<AddTripDialog> {
  final _formKey = GlobalKey<FormState>();

  String? _busId;
  String? _driverId;
  String? _routeId;
  DateTime _scheduledDate = DateTime.now();
  TimeOfDay _scheduledTime = TimeOfDay.now();

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
    final fleetState = context.watch<FleetCubit>().state;
    final driverState = context.watch<DriverCubit>().state;
    final routeState = context.watch<RouteCubit>().state;

    final scheduledAt = DateTime(
      _scheduledDate.year,
      _scheduledDate.month,
      _scheduledDate.day,
      _scheduledTime.hour,
      _scheduledTime.minute,
    );

    return AlertDialog(
      title: const Text("Schedule Trip"),
      content: SizedBox(
        width: 480,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: _busId,
                  decoration: const InputDecoration(labelText: "Bus"),
                  items: fleetState.buses
                      .map((b) => DropdownMenuItem(
                    value: b.id,
                    child: Text("${b.vehicleNumber} (${b.registration})"),
                  ))
                      .toList(),
                  onChanged: (v) => setState(() => _busId = v),
                  validator: (v) => v == null ? "Required" : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _driverId,
                  decoration: const InputDecoration(labelText: "Driver"),
                  items: driverState.drivers
                      .map((d) => DropdownMenuItem(
                    value: d.id,
                    child: Text(d.fullName),
                  ))
                      .toList(),
                  onChanged: (v) => setState(() => _driverId = v),
                  validator: (v) => v == null ? "Required" : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _routeId,
                  decoration: const InputDecoration(labelText: "Route"),
                  items: routeState.routes
                      .map((r) => DropdownMenuItem(
                    value: r.id,
                    child: Text(r.name),
                  ))
                      .toList(),
                  onChanged: (v) => setState(() => _routeId = v),
                  validator: (v) => v == null ? "Required" : null,
                ),
                const SizedBox(height: 16),
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

            final bus = fleetState.buses.firstWhere((b) => b.id == _busId);
            final driver =
            driverState.drivers.firstWhere((d) => d.id == _driverId);
            final route =
            routeState.routes.firstWhere((r) => r.id == _routeId);

            final now = DateTime.now();

            context.read<TripCubit>().addTrip(
              TripModel(
                id: now.millisecondsSinceEpoch.toString(),
                busId: bus.id,
                vehicleNumber: bus.vehicleNumber,
                driverId: driver.id,
                driverName: driver.fullName,
                routeId: route.id,
                routeName: route.name,
                scheduledAt: scheduledAt,
                createdAt: now,
                updatedAt: now,
              ),
            );

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Trip scheduled successfully")),
            );
          },
          child: const Text("Schedule"),
        ),
      ],
    );
  }
}