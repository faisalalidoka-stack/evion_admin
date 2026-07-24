import 'package:flutter/material.dart';

import 'admin_shell.dart';

class PagePlaceholder extends StatelessWidget {
  final String title;

  const PagePlaceholder({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AdminShell(
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
