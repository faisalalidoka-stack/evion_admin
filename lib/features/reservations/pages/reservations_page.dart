import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/admin_shell.dart';
import '../../../core/constants/reservation_status.dart';
import '../logic/reservation_cubit.dart';
import '../logic/reservation_state.dart';
import '../widgets/add_reservation_dialog.dart';
import '../widgets/reservation_table.dart';
import '/features/reservations/widgets/reservation_state_row.dart';

class ReservationsPage extends StatefulWidget {
  const ReservationsPage({super.key});

  @override
  State<ReservationsPage> createState() => _ReservationsPageState();
}

class _ReservationsPageState extends State<ReservationsPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdminShell(
      child: BlocConsumer<ReservationCubit, ReservationState>(
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
          final visible = state.filteredReservations;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Reservations",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: context.read<ReservationCubit>(),
                          child: const AddReservationDialog(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add Reservation"),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ReservationStatsRow(state: state),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _searchController,
                      onChanged: context.read<ReservationCubit>().setSearchQuery,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search by passenger, phone, bus or route...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<ReservationStatus>(
                      initialValue: state.statusFilter,
                      decoration: InputDecoration(
                        labelText: "Status",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      items: [
                        const DropdownMenuItem<ReservationStatus>(
                          value: null,
                          child: Text("All Statuses"),
                        ),
                        ...ReservationStatus.values.map(
                              (status) => DropdownMenuItem<ReservationStatus>(
                            value: status,
                            child: Text(status.label),
                          ),
                        ),
                      ],
                      onChanged: (value) =>
                          context.read<ReservationCubit>().setStatusFilter(value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "${visible.length} of ${state.reservations.length} reservations",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 12),
              Expanded(child: ReservationTable(reservations: visible)),
            ],
          );
        },
      ),
    );
  }
}