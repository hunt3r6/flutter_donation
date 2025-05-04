import 'package:flutter_donation/page/account_page.dart';
import 'package:flutter_donation/page/dashboard_page.dart';
import 'package:flutter_donation/page/donation_list_page.dart';
import 'package:flutter_donation/page/home_page.dart';
import 'package:flutter_donation/page/my_donations_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  late final GoRouter router = GoRouter(
    initialLocation: '/dashboard/home',
    routes: [
      ShellRoute(
        builder: (_, __, child) => DashboardPage(child: child),
        routes: [
          GoRoute(
            path: '/dashboard/home',
            builder: (_, __) {
              return HomePage();
            },
          ),
          GoRoute(
            path: '/dashboard/donation_list',
            builder: (context, state) {
              return DonationListPage();
            },
          ),
          GoRoute(
            path: '/dashboard/my_donations',
            builder: (context, state) {
              return MyDonationsPage();
            },
          ),
          GoRoute(
            path: '/dashboard/account',
            builder: (context, state) {
              return AccountPage();
            },
          ),
        ],
      ),
    ],
  );
}
