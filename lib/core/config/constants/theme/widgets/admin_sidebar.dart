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
