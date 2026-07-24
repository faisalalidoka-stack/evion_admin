import 'package:flutter/material.dart';

class SidebarItem {
  final String title;
  final IconData icon;
  final String route;

  const SidebarItem({
    required this.title,
    required this.icon,
    required this.route,
  });
}
