import 'package:flutter/material.dart';

class ActivityPanel extends StatelessWidget {
  const ActivityPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      ("Bus EV-001 departed", Icons.directions_bus, Colors.blue),
      ("Driver John went online", Icons.person, Colors.green),
      ("Reservation boarded", Icons.confirmation_number, Colors.orange),
      ("Trip completed", Icons.check_circle, Colors.purple),
      ("Driver Sarah logged in", Icons.login, Colors.teal),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's Activity",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ...activities.map(
                  (activity) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: (activity.$3 as Color).withOpacity(.15),
                  child: Icon(
                    activity.$2 as IconData,
                    color: activity.$3 as Color,
                  ),
                ),
                title: Text(activity.$1 as String),
                subtitle: const Text("Just now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}