import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/fleet_cubit.dart';
import '../models/bus_model.dart';

class AddBusDialog extends StatefulWidget {
  const AddBusDialog({super.key});

  @override
  State<AddBusDialog> createState() => _AddBusDialogState();
}

class _AddBusDialogState extends State<AddBusDialog> {
  final _formKey = GlobalKey<FormState>();

  final vehicleController = TextEditingController();
  final registrationController = TextEditingController();
  final routeController = TextEditingController();
  final driverController = TextEditingController();
  final capacityController = TextEditingController();

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
      title: const Text("Add Bus"),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: vehicleController,
                  decoration: const InputDecoration(
                    labelText: "Vehicle Number",
                  ),
                  validator: (v) =>
                  v == null || v.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: registrationController,
                  decoration: const InputDecoration(
                    labelText: "Registration",
                  ),
                  validator: (v) =>
                  v == null || v.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: routeController,
                  decoration: const InputDecoration(
                    labelText: "Route",
                  ),
                  validator: (v) =>
                  v == null || v.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: driverController,
                  decoration: const InputDecoration(
                    labelText: "Driver",
                  ),
                  validator: (v) =>
                  v == null || v.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: capacityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Capacity",
                  ),
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
        ElevatedButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;

            final now = DateTime.now();

            context.read<FleetCubit>().addBus(
              BusModel(
                id: now.millisecondsSinceEpoch.toString(),
                vehicleNumber: vehicleController.text.trim(),
                registration: registrationController.text.trim(),
                capacity: int.parse(capacityController.text),
                routeName: routeController.text.trim(),
                driverName: driverController.text.trim(),
                status: BusStatus.offline,
                createdAt: now,
                updatedAt: now,
              ),
            );

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Bus added successfully"),
              ),
            );
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}