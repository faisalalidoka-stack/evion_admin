import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/admin_shell.dart';
import '../../../core/constants/trip_status.dart';
import '../logic/trip_cubit.dart';
import '../logic/trip_state.dart';
import '../widgets/add_trip_dialog.dart';
import '../widgets/trip_stats_row.dart';
import '../widgets/trip_table.dart';

class TripsPage extends StatefulWidget {
  const TripsPage({super.key});

  @override
  State<TripsPage> createState() => _TripsPageState();
}

class _TripsPageState extends State<TripsPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdminShell(
      child: BlocConsumer<TripCubit, TripState>(
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
          final visibleTrips = state.filteredTrips;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Trips",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: context.read<TripCubit>(),
                          child: const AddTripDialog(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Schedule Trip"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TripStatsRow(state: state),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _searchController,
                      onChanged: context.read<TripCubit>().setSearchQuery,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search by bus, driver or route...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<TripStatus>(
                      initialValue: state.statusFilter,
                      decoration: InputDecoration(
                        labelText: "Status",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: [
                        const DropdownMenuItem<TripStatus>(
                          value: null,
                          child: Text("All Statuses"),
                        ),
                        ...TripStatus.values.map(
                              (status) => DropdownMenuItem<TripStatus>(
                            value: status,
                            child: Text(status.label),
                          ),
                        ),
                      ],
                      onChanged: (value) =>
                          context.read<TripCubit>().setStatusFilter(value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "${visibleTrips.length} of ${state.trips.length} trips",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 12),
              Expanded(child: TripTable(trips: visibleTrips)),
            ],
          );
        },
      ),
    );
  }
}