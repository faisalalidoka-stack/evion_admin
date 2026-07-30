import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/admin_shell.dart';
import '../logic/stop_cubit.dart';
import '../logic/stop_state.dart';
import '../widgets/add_stop_dialog.dart';
import '../widgets/stop_table.dart';

class StopsPage extends StatefulWidget {
  const StopsPage({super.key});

  @override
  State<StopsPage> createState() => _StopsPageState();
}

class _StopsPageState extends State<StopsPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdminShell(
      child: BlocConsumer<StopCubit, StopState>(
        listenWhen: (previous, current) =>
        previous.errorMessage != current.errorMessage &&
            current.errorMessage != null,
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red.shade700,
              content: Text("Error: ${state.errorMessage}"),
              duration: const Duration(seconds: 6),
            ),
          );
        },
        builder: (context, state) {
          final visibleStops = state.filteredStops;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Stops",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: context.read<StopCubit>(),
                          child: const AddStopDialog(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add Stop"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _searchController,
                      onChanged: context.read<StopCubit>().setSearchQuery,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search by name or address...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<bool>(
                      initialValue: state.activeFilter,
                      decoration: InputDecoration(
                        labelText: "Active",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem<bool>(value: null, child: Text("All Stops")),
                        DropdownMenuItem<bool>(value: true, child: Text("Active Only")),
                        DropdownMenuItem<bool>(value: false, child: Text("Inactive Only")),
                      ],
                      onChanged: (value) =>
                          context.read<StopCubit>().setActiveFilter(value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "${visibleStops.length} of ${state.stops.length} stops",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 12),
              Expanded(child: StopTable(stops: visibleStops)),
            ],
          );
        },
      ),
    );
  }
}