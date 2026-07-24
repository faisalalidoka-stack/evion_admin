import 'package:flutter/material.dart';

import 'admin_sidebar.dart';

class AdminShell extends StatelessWidget {
  final Widget child;

  const AdminShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EViON Admin")),
      body: Row(
        children: [
          const AdminSidebar(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
