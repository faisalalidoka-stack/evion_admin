import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/admin_shell.dart';
import '../logic/fleet_cubit.dart';
import '../logic/fleet_state.dart';
import '../widgets/fleet_table.dart';
import '../widgets/add_bus_dialog.dart';

class FleetPage extends StatelessWidget {
  const FleetPage({super.key});

  // Fixed: Moved the helper method to the correct class level
  void _showDeleteDialog(BuildContext context, String busId) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Bus"),
        content: const Text(
          "Are you sure you want to delete this bus?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red), // Optional: Make it visually a delete button
            onPressed: () {
              context.read<FleetCubit>().deleteBus(busId);
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdminShell(
      child: BlocBuilder<FleetCubit, FleetState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Fleet Management",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const AddBusDialog(),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add Bus"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search buses...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FleetTable(
                  buses: state.buses,
                  // Note: You will need to pass `_showDeleteDialog` into your FleetTable
                  // or pass a callback down so the table rows can trigger it.
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
