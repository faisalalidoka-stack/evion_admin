import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/driver_cubit.dart';
import '../models/driver_model.dart';

class DeleteDriverDialog extends StatelessWidget {
  final DriverModel driver;

  const DeleteDriverDialog({
    super.key,
    required this.driver,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.delete_forever,
        color: Colors.red,
      ),
      title: const Text("Delete Driver"),
      content: Text(
        "Delete ${driver.fullName}?",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () async {
            await context
                .read<DriverCubit>()
                .deleteDriver(driver.id);

            if (!context.mounted) return;

            Navigator.pop(context);
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}