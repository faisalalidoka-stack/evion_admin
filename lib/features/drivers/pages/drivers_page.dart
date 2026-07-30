import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/admin_shell.dart';
import '../logic/driver_cubit.dart';
import '../logic/driver_state.dart';
import '../widgets/add_driver_dialog.dart';
import '../widgets/driver_search_bar.dart';
import '../widgets/driver_table.dart';

class DriversPage extends StatelessWidget {
  const DriversPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminShell(
      child: BlocBuilder<DriverCubit, DriverState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Drivers",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  FilledButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text("Add Driver"),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: context.read<DriverCubit>(),
                          child: const AddDriverDialog(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              DriverSearchBar(
                onChanged: context.read<DriverCubit>().search,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: DriverTable(
                  drivers: state.filteredDrivers,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}