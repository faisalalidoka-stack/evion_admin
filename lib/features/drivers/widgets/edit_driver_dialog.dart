import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/driver_cubit.dart';
import '../models/driver_model.dart';

class EditDriverDialog extends StatefulWidget {
  final DriverModel driver;

  const EditDriverDialog({
    super.key,
    required this.driver,
  });

  @override
  State<EditDriverDialog> createState() => _EditDriverDialogState();
}

class _EditDriverDialogState extends State<EditDriverDialog> {
  late final TextEditingController employee;
  late final TextEditingController name;
  late final TextEditingController phone;
  late final TextEditingController email;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    employee = TextEditingController(text: widget.driver.employeeId);
    name = TextEditingController(text: widget.driver.fullName);
    phone = TextEditingController(text: widget.driver.phone);
    email = TextEditingController(text: widget.driver.email);
  }

  @override
  void dispose() {
    employee.dispose();
    name.dispose();
    phone.dispose();
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Driver"),
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
                v == null || v.isEmpty ? "Required" : null,
              ),
              TextFormField(
                controller: name,
                decoration:
                const InputDecoration(labelText: "Full Name"),
                validator: (v) =>
                v == null || v.isEmpty ? "Required" : null,
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
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: () async {
            if (!formKey.currentState!.validate()) return;

            await context.read<DriverCubit>().updateDriver(
              widget.driver.copyWith(
                employeeId: employee.text.trim(),
                fullName: name.text.trim(),
                phone: phone.text.trim(),
                email: email.text.trim(),
              ),
            );

            if (!mounted) return;

            Navigator.pop(context);
          },
          child: const Text("Update"),
        ),
      ],
    );
  }
}