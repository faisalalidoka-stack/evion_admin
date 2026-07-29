import 'package:go_router/go_router.dart';

import '../../core/widgets/page_placeholder.dart';
import '../../features/authentication/logic/auth_cubit.dart';
import '../../features/authentication/logic/auth_state.dart';
import '../../features/authentication/pages/login_page.dart';
import '../../features/dashboards/pages/dashboard_page.dart';
import '../../features/fleet/pages/fleet_page.dart';
import '../utils/go_router_refresh_stream.dart';

class AppRouter {
  static GoRouter build(AuthCubit authCubit) {
    return GoRouter(
      initialLocation: '/',
      refreshListenable: GoRouterRefreshStream(authCubit.stream),
      redirect: (context, state) {
        final authState = authCubit.state;
        final loggingIn = state.matchedLocation == '/login';

        if (authState.status == AuthStatus.unknown) {
          return null;
        }

        final isAuthenticated = authState.status == AuthStatus.authenticated;

        if (!isAuthenticated && !loggingIn) return '/login';
        if (isAuthenticated && loggingIn) return '/';

        return null;
      },
      routes: [
        GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
        GoRoute(path: '/', builder: (_, __) => const DashboardPage()),
        GoRoute(
          path: '/fleet',
          builder: (_, __) => const FleetPage(),
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
        GoRoute(
          path: "/drivers",
          builder: (_, __) => const DriversPage(),
        ),
      ],
    );
  }
}