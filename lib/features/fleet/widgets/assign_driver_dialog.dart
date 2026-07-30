import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../drivers/logic/driver_cubit.dart';
import '../../drivers/logic/driver_state.dart';
import '../../drivers/models/driver_model.dart';
import '../logic/fleet_cubit.dart';
import '../models/bus_model.dart';

class AssignDriverDialog extends StatefulWidget {
  final BusModel bus;

  const AssignDriverDialog({super.key, required this.bus});

  @override
  State<AssignDriverDialog> createState() => _AssignDriverDialogState();
}

class _AssignDriverDialogState extends State<AssignDriverDialog> {
  String? _selectedDriverId;

  @override
  void initState() {
    super.initState();
    _selectedDriverId =
    widget.bus.driverId.isNotEmpty ? widget.bus.driverId : null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Assign Driver"),
      content: SizedBox(
        width: 420,
        child: BlocBuilder<DriverCubit, DriverState>(
          builder: (context, state) {
            if (state.loading) {
              return const SizedBox(
                height: 80,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final eligible = state.drivers
                .where((d) =>
            d.assignedBusId.isEmpty || d.id == widget.bus.driverId)
                .toList();

            if (eligible.isEmpty) {
              return const Text("No drivers available to assign.");
            }

            return DropdownButtonFormField<String>(
              initialValue: _selectedDriverId,
              decoration: const InputDecoration(labelText: "Driver"),
              items: eligible
                  .map(
                    (d) => DropdownMenuItem(
                  value: d.id,
                  child: Text("${d.fullName} (${d.phone})"),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() => _selectedDriverId = value);
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: _selectedDriverId == null
              ? null
              : () async {
            final driverCubit = context.read<DriverCubit>();
            final fleetCubit = context.read<FleetCubit>();

            final DriverModel selected = driverCubit.state.drivers
                .firstWhere((d) => d.id == _selectedDriverId);

            final previousDriverId = widget.bus.driverId;
            if (previousDriverId.isNotEmpty &&
                previousDriverId != selected.id) {
              final DriverModel? previous =
                  driverCubit.state.drivers.where((d) => d.id == previousDriverId).firstOrNull;
              if (previous != null) {
                await driverCubit
                    .updateDriver(previous.copyWith(assignedBusId: ''));
              }
            }

            await driverCubit.updateDriver(
              selected.copyWith(assignedBusId: widget.bus.id),
            );

            await fleetCubit.assignDriver(
              busId: widget.bus.id,
              driverId: selected.id,
              driverName: selected.fullName,
            );

            if (context.mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "${selected.fullName} assigned to ${widget.bus.vehicleNumber}",
                  ),
                ),
              );
            }
          },
          child: const Text("Assign"),
        ),
      ],
    );
  }
}