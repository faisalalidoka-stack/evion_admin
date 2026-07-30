import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/stop_cubit.dart';
import '../models/stop_model.dart';

class EditStopDialog extends StatefulWidget {
  final StopModel stop;

  const EditStopDialog({super.key, required this.stop});

  @override
  State<EditStopDialog> createState() => _EditStopDialogState();
}

class _EditStopDialogState extends State<EditStopDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController addressController;
  late final TextEditingController latController;
  late final TextEditingController lngController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.stop.name);
    addressController = TextEditingController(text: widget.stop.address);
    latController = TextEditingController(text: widget.stop.latitude.toString());
    lngController = TextEditingController(text: widget.stop.longitude.toString());
  }

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
      title: const Text("Edit Stop"),
      content: SizedBox(
        width: 500,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
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
        FilledButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;

            context.read<StopCubit>().updateStop(
              widget.stop.copyWith(
                name: nameController.text.trim(),
                address: addressController.text.trim(),
                latitude: double.parse(latController.text),
                longitude: double.parse(lngController.text),
                updatedAt: DateTime.now(),
              ),
            );

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Stop updated successfully")),
            );
          },
          child: const Text("Update"),
        ),
      ],
    );
  }
}