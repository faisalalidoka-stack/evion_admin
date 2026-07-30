import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../stops/logic/stop_cubit.dart';
import '../../stops/logic/stop_state.dart';
import '../../stops/models/stop_model.dart';

class StopPickerField extends StatelessWidget {
  final List<String> selectedStopIds;
  final ValueChanged<List<String>> onChanged;

  const StopPickerField({
    super.key,
    required this.selectedStopIds,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StopCubit, StopState>(
      builder: (context, state) {
        if (state.loading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final Map<String, StopModel> stopsById = {
          for (final s in state.stops) s.id: s,
        };

        final available =
        state.stops.where((s) => !selectedStopIds.contains(s.id)).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Stops on this route (in order)",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            if (selectedStopIds.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "No stops added yet.",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            else
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: selectedStopIds.length,
                onReorder: (oldIndex, newIndex) {
                  final updated = List<String>.from(selectedStopIds);
                  if (newIndex > oldIndex) newIndex -= 1;
                  final item = updated.removeAt(oldIndex);
                  updated.insert(newIndex, item);
                  onChanged(updated);
                },
                itemBuilder: (context, index) {
                  final stopId = selectedStopIds[index];
                  final stop = stopsById[stopId];
                  return ListTile(
                    key: ValueKey(stopId),
                    dense: true,
                    leading: CircleAvatar(
                      radius: 12,
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    title: Text(stop?.name ?? "Unknown stop"),
                    subtitle: stop != null ? Text(stop.address) : null,
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                      onPressed: () {
                        final updated = List<String>.from(selectedStopIds)
                          ..removeAt(index);
                        onChanged(updated);
                      },
                    ),
                  );
                },
              ),
            const SizedBox(height: 12),
            if (available.isNotEmpty)
              DropdownButtonFormField<String>(
                key: const ValueKey('add-stop-dropdown'),
                initialValue: null,
                decoration: const InputDecoration(
                  labelText: "Add a stop",
                  border: OutlineInputBorder(),
                ),
                items: available
                    .map(
                      (s) => DropdownMenuItem(
                    value: s.id,
                    child: Text(s.name),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  onChanged([...selectedStopIds, value]);
                },
              )
            else if (state.stops.isEmpty)
              const Text(
                "No stops exist yet — create some in the Stops page first.",
                style: TextStyle(color: Colors.orange),
              ),
          ],
        );
      },
    );
  }
}