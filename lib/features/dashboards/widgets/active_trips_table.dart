import 'package:flutter/material.dart';

class ActiveTripsTable extends StatelessWidget {
  const ActiveTripsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: DataTable(
          columns: const [
            DataColumn(label: Text("Bus")),
            DataColumn(label: Text("Driver")),
            DataColumn(label: Text("Route")),
            DataColumn(label: Text("Passengers")),
            DataColumn(label: Text("Status")),
          ],
          rows: [
            DataRow(
              cells: [
                const DataCell(Text("EV-001")),
                const DataCell(Text("John")),
                const DataCell(Text("Kampala → Entebbe")),
                const DataCell(Text("24")),
                DataCell(
                  Chip(
                    label: const Text("Running"),
                    backgroundColor: Colors.green.shade100,
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                const DataCell(Text("EV-007")),
                const DataCell(Text("Sarah")),
                const DataCell(Text("Ntinda → CBD")),
                const DataCell(Text("17")),
                DataCell(
                  Chip(
                    label: const Text("Boarding"),
                    backgroundColor: Colors.orange.shade100,
                  ),
                ),
              ],
            ),
            DataRow(
              cells: [
                const DataCell(Text("EV-011")),
                const DataCell(Text("Moses")),
                const DataCell(Text("Mukono → Kampala")),
                const DataCell(Text("31")),
                DataCell(
                  Chip(
                    label: const Text("Running"),
                    backgroundColor: Colors.green.shade100,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}