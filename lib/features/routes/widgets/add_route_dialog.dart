import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/route_cubit.dart';
import '../models/route_model.dart';
import 'stop_picker_field.dart';

class AddRouteDialog extends StatefulWidget {
  const AddRouteDialog({super.key});

  @override
  State<AddRouteDialog> createState() => _AddRouteDialogState();
}

class _AddRouteDialogState extends State<AddRouteDialog> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final distanceController = TextEditingController();
  final durationController = TextEditingController();

  List<String> _stopIds = [];

  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    distanceController.dispose();
    durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Route"),
      content: SizedBox(
        width: 520,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Route Name"),
                  validator: (v) =>
                  v == null || v.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: codeController,
                  decoration: const InputDecoration(labelText: "Route Code"),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: distanceController,
                        keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(labelText: "Distance (km)"),
                        validator: (v) {
                          if (v == null || v.isEmpty) return null;
                          if (double.tryParse(v) == null) return "Invalid";
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: durationController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Duration (min)"),
                        validator: (v) {
                          if (v == null || v.isEmpty) return null;
                          if (int.tryParse(v) == null) return "Invalid";
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                StopPickerField(
                  selectedStopIds: _stopIds,
                  onChanged: (ids) => setState(() => _stopIds = ids),
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

            context.read<RouteCubit>().addRoute(
              RouteModel(
                id: now.millisecondsSinceEpoch.toString(),
                name: nameController.text.trim(),
                code: codeController.text.trim(),
                stopIds: _stopIds,
                distanceKm: double.tryParse(distanceController.text) ?? 0,
                estimatedDurationMinutes:
                int.tryParse(durationController.text) ?? 0,
                createdAt: now,
                updatedAt: now,
              ),
            );

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Route added successfully")),
            );
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}