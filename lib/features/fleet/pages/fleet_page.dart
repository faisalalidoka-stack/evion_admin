import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/admin_shell.dart';
import '../../../core/constants/bus_status.dart';
import '../logic/fleet_cubit.dart';
import '../logic/fleet_state.dart';
import '../widgets/fleet_stats_row.dart';
import '../widgets/fleet_table.dart';
import '../widgets/add_bus_dialog.dart';

class FleetPage extends StatefulWidget {
  const FleetPage({super.key});

  @override
  State<FleetPage> createState() => _FleetPageState();
}

class _FleetPageState extends State<FleetPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdminShell(
      child: BlocConsumer<FleetCubit, FleetState>(
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
          final visibleBuses = state.filteredBuses;

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
                  OutlinedButton.icon(
                    onPressed: () =>
                        context.read<FleetCubit>().seedSampleData(),
                    icon: const Icon(Icons.cloud_upload_outlined),
                    label: const Text("Seed Sample Data"),
                  ),
                  const SizedBox(width: 12),
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
              FleetStatsRow(state: state),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _searchController,
                      onChanged: context.read<FleetCubit>().setSearchQuery,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText:
                        "Search by vehicle, registration, driver or route...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<BusStatus>(
                      initialValue: state.statusFilter,
                      decoration: InputDecoration(
                        labelText: "Status",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: [
                        const DropdownMenuItem<BusStatus>(
                          value: null,
                          child: Text("All Statuses"),
                        ),
                        ...BusStatus.values.map(
                              (status) => DropdownMenuItem<BusStatus>(
                            value: status,
                            child: Text(status.label),
                          ),
                        ),
                      ],
                      onChanged: (value) =>
                          context.read<FleetCubit>().setStatusFilter(value),
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
                        DropdownMenuItem<bool>(
                          value: null,
                          child: Text("All Buses"),
                        ),
                        DropdownMenuItem<bool>(
                          value: true,
                          child: Text("Active Only"),
                        ),
                        DropdownMenuItem<bool>(
                          value: false,
                          child: Text("Inactive Only"),
                        ),
                      ],
                      onChanged: (value) =>
                          context.read<FleetCubit>().setActiveFilter(value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "${visibleBuses.length} of ${state.buses.length} buses",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: FleetTable(
                  buses: visibleBuses,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}