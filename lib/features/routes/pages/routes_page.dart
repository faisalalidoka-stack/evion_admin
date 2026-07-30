import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/admin_shell.dart';
import '../logic/route_cubit.dart';
import '../logic/route_state.dart';
import '../widgets/add_route_dialog.dart';
import '../widgets/route_table.dart';

class RoutesPage extends StatefulWidget {
  const RoutesPage({super.key});

  @override
  State<RoutesPage> createState() => _RoutesPageState();
}

class _RoutesPageState extends State<RoutesPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdminShell(
      child: BlocConsumer<RouteCubit, RouteState>(
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
          final visibleRoutes = state.filteredRoutes;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Routes",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: context.read<RouteCubit>(),
                          child: const AddRouteDialog(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add Route"),
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
                      onChanged: context.read<RouteCubit>().setSearchQuery,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search by name or code...",
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
                        DropdownMenuItem<bool>(value: null, child: Text("All Routes")),
                        DropdownMenuItem<bool>(value: true, child: Text("Active Only")),
                        DropdownMenuItem<bool>(value: false, child: Text("Inactive Only")),
                      ],
                      onChanged: (value) =>
                          context.read<RouteCubit>().setActiveFilter(value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "${visibleRoutes.length} of ${state.routes.length} routes",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 12),
              Expanded(child: RouteTable(routes: visibleRoutes)),
            ],
          );
        },
      ),
    );
  }
}