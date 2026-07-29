import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/sidebar_item.dart';

class AdminSidebar extends StatelessWidget {
  const AdminSidebar({super.key});

  static const items = [
    SidebarItem(
      title: 'Dashboard',
      icon: Icons.dashboard_rounded,
      route: '/',
    ),
    SidebarItem(
      title: 'Fleet',
      icon: Icons.directions_bus,
      route: '/fleet',
    ),
    SidebarItem(
      title: 'Drivers',
      icon: Icons.people,
      route: '/drivers',
    ),
    SidebarItem(
      title: 'Routes',
      icon: Icons.route,
      route: '/routes',
    ),
    SidebarItem(
      title: 'Stops',
      icon: Icons.location_on,
      route: '/stops',
    ),
    SidebarItem(
      title: 'Trips',
      icon: Icons.alt_route,
      route: '/trips',
    ),
    SidebarItem(
      title: 'Reservations',
      icon: Icons.confirmation_number,
      route: '/reservations',
    ),
    SidebarItem(
      title: 'Analytics',
      icon: Icons.analytics,
      route: '/analytics',
    ),
    SidebarItem(
      title: 'Settings',
      icon: Icons.settings,
      route: '/settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final current = GoRouterState.of(context).uri.path;

    return Container(
      width: 250,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Color(0xffE5E7EB)),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          const FlutterLogo(size: 70),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (_, index) {
                final item = items[index];
                final selected = current == item.route;

                return ListTile(
                  selected: selected,
                  selectedTileColor: Colors.blue.shade50,
                  leading: Icon(
                    item.icon,
                    color: selected ? Colors.blue : Colors.grey,
                  ),
                  title: Text(item.title),
                  onTap: () => context.go(item.route),
                );
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Drivers"),
                  onTap: () => context.go("/drivers"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}