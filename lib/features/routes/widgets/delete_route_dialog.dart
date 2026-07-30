import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/route_cubit.dart';
import '../models/route_model.dart';

class DeleteRouteDialog extends StatelessWidget {
  final RouteModel route;

  const DeleteRouteDialog({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.delete_forever, color: Colors.red, size: 42),
      title: const Text("Delete Route"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Are you sure you want to delete this route?"),
          const SizedBox(height: 16),
          Text(
            route.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          if (route.code.isNotEmpty) Text(route.code),
          const SizedBox(height: 8),
          const Text(
            "This action cannot be undone. Buses currently assigned to this route will keep a stale routeId.",
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
            context.read<RouteCubit>().deleteRoute(route.id);

            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("${route.name} deleted successfully")),
            );
          },
        ),
      ],
    );
  }
}