import 'package:flutter/material.dart';

class DriverSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const DriverSearchBar({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Search drivers...",
        ),
        onChanged: onChanged,
      ),
    );
  }
}