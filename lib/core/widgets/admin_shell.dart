import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/authentication/logic/auth_cubit.dart';
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
        actions: [
          const Icon(Icons.notifications_none),
          const SizedBox(width: 20),
          const CircleAvatar(child: Icon(Icons.person)),
          const SizedBox(width: 12),
          IconButton(
            tooltip: "Sign out",
            onPressed: () => context.read<AuthCubit>().signOut(),
            icon: const Icon(Icons.logout),
          ),
          const SizedBox(width: 12),
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