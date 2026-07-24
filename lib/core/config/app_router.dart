import 'package:go_router/go_router.dart';

import '../../core/widgets/page_placeholder.dart';
import '../../features/dashboard/pages/dashboard_page.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (_, __) => const DashboardPage()),
      GoRoute(
        path: '/fleet',
        builder: (_, __) => const PagePlaceholder(title: "Fleet"),
      ),
      GoRoute(
        path: '/drivers',
        builder: (_, __) => const PagePlaceholder(title: "Drivers"),
      ),
      GoRoute(
        path: '/routes',
        builder: (_, __) => const PagePlaceholder(title: "Routes"),
      ),
      GoRoute(
        path: '/stops',
        builder: (_, __) => const PagePlaceholder(title: "Stops"),
      ),
      GoRoute(
        path: '/trips',
        builder: (_, __) => const PagePlaceholder(title: "Trips"),
      ),
      GoRoute(
        path: '/reservations',
        builder: (_, __) => const PagePlaceholder(title: "Reservations"),
      ),
      GoRoute(
        path: '/analytics',
        builder: (_, __) => const PagePlaceholder(title: "Analytics"),
      ),
      GoRoute(
        path: '/settings',
        builder: (_, __) => const PagePlaceholder(title: "Settings"),
      ),
    ],
  );
}
