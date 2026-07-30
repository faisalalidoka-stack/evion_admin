import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/stop_cubit.dart';
import '../models/stop_model.dart';

class AddStopDialog extends StatefulWidget {
  const AddStopDialog({super.key});

  @override
  State<AddStopDialog> createState() => _AddStopDialogState();
}

class _AddStopDialogState extends State<AddStopDialog> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    latController.dispose();
    lngController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Stop"),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: "Stop Name"),
                  validator: (v) =>
                  v == null || v.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(labelText: "Address"),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: latController,
                        keyboardType:
                        const TextInputType.numberWithOptions(decimal: true, signed: true),
                        decoration: const InputDecoration(labelText: "Latitude"),
                        validator: (v) {
                          if (v == null || v.isEmpty) return "Required";
                          if (double.tryParse(v) == null) return "Invalid";
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: lngController,
                        keyboardType:
                        const TextInputType.numberWithOptions(decimal: true, signed: true),
                        decoration: const InputDecoration(labelText: "Longitude"),
                        validator: (v) {
                          if (v == null || v.isEmpty) return "Required";
                          if (double.tryParse(v) == null) return "Invalid";
                          return null;
                        },
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

            final now = DateTime.now();

            context.read<StopCubit>().addStop(
              StopModel(
                id: now.millisecondsSinceEpoch.toString(),
                name: nameController.text.trim(),
                address: addressController.text.trim(),
                latitude: double.parse(latController.text),
                longitude: double.parse(lngController.text),
                createdAt: now,
                updatedAt: now,
              ),
            );

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Stop added successfully")),
            );
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}