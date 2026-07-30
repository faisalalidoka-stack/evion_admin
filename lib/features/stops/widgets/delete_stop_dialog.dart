import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/stop_cubit.dart';
import '../models/stop_model.dart';

class DeleteStopDialog extends StatelessWidget {
  final StopModel stop;

  const DeleteStopDialog({super.key, required this.stop});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.delete_forever, color: Colors.red, size: 42),
      title: const Text("Delete Stop"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Are you sure you want to delete this stop?"),
          const SizedBox(height: 16),
          Text(
            stop.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(stop.address),
          const SizedBox(height: 8),
          const Text(
            "This action cannot be undone.",
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: Colors.red),
          icon: const Icon(Icons.delete),
          label: const Text("Delete"),
          onPressed: () {
            context.read<StopCubit>().deleteStop(stop.id);

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("${stop.name} deleted successfully")),
            );
          },
        ),
      ],
    );
  }
}