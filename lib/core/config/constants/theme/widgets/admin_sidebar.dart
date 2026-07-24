import 'package:flutter/material.dart';

class AdminSidebar extends StatelessWidget {
  const AdminSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: Colors.white,
      child: ListView(
        children: const [
          DrawerHeader(child: FlutterLogo(size: 70)),
          ListTile(leading: Icon(Icons.dashboard), title: Text("Dashboard")),
          ListTile(leading: Icon(Icons.directions_bus), title: Text("Fleet")),
          ListTile(leading: Icon(Icons.people), title: Text("Drivers")),
          ListTile(leading: Icon(Icons.route), title: Text("Routes")),
          ListTile(leading: Icon(Icons.location_on), title: Text("Stops")),
          ListTile(leading: Icon(Icons.alt_route), title: Text("Trips")),
          ListTile(
            leading: Icon(Icons.confirmation_number),
            title: Text("Reservations"),
          ),
          ListTile(leading: Icon(Icons.analytics), title: Text("Analytics")),
          ListTile(leading: Icon(Icons.settings), title: Text("Settings")),
        ],
      ),
    );
  }
}
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
              },
            ),
          ),
        ],
      ),
    );
  }
}