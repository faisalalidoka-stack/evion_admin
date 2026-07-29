import 'package:flutter/material.dart';

class FleetStatusFilters extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelected;

  const FleetStatusFilters({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  static const filters = [
    "All",
    "Running",
    "Boarding",
    "Offline",
    "Maintenance",
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: filters.map((status) {
        return FilterChip(
          label: Text(status),
          selected: selected == status,
          onSelected: (_) => onSelected(status),
        );
      }).toList(),
    );
  }
}