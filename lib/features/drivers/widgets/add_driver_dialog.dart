import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/driver_cubit.dart';
import '../models/driver_model.dart';

class AddDriverDialog extends StatefulWidget {
  const AddDriverDialog({super.key});

  @override
  State<AddDriverDialog> createState() =>
      _AddDriverDialogState();
}

class _AddDriverDialogState
    extends State<AddDriverDialog> {
  final formKey = GlobalKey<FormState>();

  final employee = TextEditingController();

  final name = TextEditingController();

  final phone = TextEditingController();

  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Driver"),
      content: SizedBox(
        width: 450,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: employee,
                decoration:
                const InputDecoration(labelText: "Employee ID"),
                validator: (v) =>
                v!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: name,
                decoration:
                const InputDecoration(labelText: "Full Name"),
                validator: (v) =>
                v!.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: phone,
                decoration:
                const InputDecoration(labelText: "Phone"),
              ),
              TextFormField(
                controller: email,
                decoration:
                const InputDecoration(labelText: "Email"),
              ),
            ],
          ),
        ),
      ),
      actions: [
        FilledButton(
          onPressed: () async {
            if (!formKey.currentState!.validate()) return;

            await context.read<DriverCubit>().addDriver(
              DriverModel(
                id: DateTime.now()
                    .millisecondsSinceEpoch
                    .toString(),
                employeeId: employee.text,
                fullName: name.text,
                phone: phone.text,
                email: email.text,
                assignedBusId: "",
                online: false,
                active: true,
              ),
            );

            if (!mounted) return;

            Navigator.pop(context);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}