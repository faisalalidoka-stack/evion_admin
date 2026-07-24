import 'package:flutter/material.dart';

import 'admin_sidebar.dart';

class AdminShell extends StatelessWidget {
  final Widget child;

  const AdminShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      appBar: AppBar(
        title: const Text("EViON Admin"),
        actions: const [
          Icon(Icons.notifications_none),
          SizedBox(width: 20),
          CircleAvatar(child: Icon(Icons.person)),
          SizedBox(width: 20),
        ],
      ),
      body: Row(
        children: [
          const AdminSidebar(),
          Expanded(
            child: Padding(padding: const EdgeInsets.all(24), child: child),
          ),
        ],
      ),
    );
  }
}
