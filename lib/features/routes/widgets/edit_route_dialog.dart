import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/route_cubit.dart';
import '../models/route_model.dart';
import 'stop_picker_field.dart';

class EditRouteDialog extends StatefulWidget {
  final RouteModel route;

  const EditRouteDialog({super.key, required this.route});

  @override
  State<EditRouteDialog> createState() => _EditRouteDialogState();
}

class _EditRouteDialogState extends State<EditRouteDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController codeController;
  late final TextEditingController distanceController;
  late final TextEditingController durationController;

  late List<String> _stopIds;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.route.name);
    codeController = TextEditingController(text: widget.route.code);
    distanceController =
        TextEditingController(text: widget.route.distanceKm.toString());
    durationController = TextEditingController(
        text: widget.route.estimatedDurationMinutes.toString());
    _stopIds = List<String>.from(widget.route.stopIds);
  }

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
      title: const Text("Edit Route"),
      content: SizedBox(
        width: 520,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
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
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;

            context.read<RouteCubit>().updateRoute(
              widget.route.copyWith(
                name: nameController.text.trim(),
                code: codeController.text.trim(),
                stopIds: _stopIds,
                distanceKm: double.tryParse(distanceController.text) ?? 0,
                estimatedDurationMinutes:
                int.tryParse(durationController.text) ?? 0,
                updatedAt: DateTime.now(),
              ),
            );

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Route updated successfully")),
            );
          },
          child: const Text("Update"),
        ),
      ],
    );
  }
}