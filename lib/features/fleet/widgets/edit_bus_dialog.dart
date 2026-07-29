import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/fleet_cubit.dart';
import '../models/bus_model.dart';

class EditBusDialog extends StatefulWidget {
  final BusModel bus;

  const EditBusDialog({
    super.key,
    required this.bus,
  });

  @override
  State<EditBusDialog> createState() => _EditBusDialogState();
}

class _EditBusDialogState extends State<EditBusDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController vehicleController;
  late final TextEditingController registrationController;
  late final TextEditingController routeController;
  late final TextEditingController driverController;
  late final TextEditingController capacityController;

  @override
  void initState() {
    super.initState();

    vehicleController =
        TextEditingController(text: widget.bus.vehicleNumber);

    registrationController =
        TextEditingController(text: widget.bus.registration);

    routeController =
        TextEditingController(text: widget.bus.routeName);

    driverController =
        TextEditingController(text: widget.bus.driverName);

    capacityController =
        TextEditingController(text: widget.bus.capacity.toString());
  }

  @override
  void dispose() {
    vehicleController.dispose();
    registrationController.dispose();
    routeController.dispose();
    driverController.dispose();
    capacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Bus"),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: vehicleController,
                  decoration:
                  const InputDecoration(labelText: "Vehicle Number"),
                  validator: (v) =>
                  v == null || v.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: registrationController,
                  decoration:
                  const InputDecoration(labelText: "Registration"),
                  validator: (v) =>
                  v == null || v.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: routeController,
                  decoration:
                  const InputDecoration(labelText: "Route"),
                  validator: (v) =>
                  v == null || v.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: driverController,
                  decoration:
                  const InputDecoration(labelText: "Driver"),
                  validator: (v) =>
                  v == null || v.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: capacityController,
                  keyboardType: TextInputType.number,
                  decoration:
                  const InputDecoration(labelText: "Capacity"),
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Required";
                    }

                    if (int.tryParse(v) == null) {
                      return "Invalid number";
                    }

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
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;

            context.read<FleetCubit>().updateBus(
              widget.bus.copyWith(
                vehicleNumber: vehicleController.text.trim(),
                registration: registrationController.text.trim(),
                capacity: int.parse(capacityController.text),
                routeName: routeController.text.trim(),
                driverName: driverController.text.trim(),
                updatedAt: DateTime.now(),
              ),
            );

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Bus updated successfully"),
              ),
            );
          },
          child: const Text("Update"),
        )
      ],
    );
  }
}