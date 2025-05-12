import 'package:flutter_donation/page/dashboard/account_page.dart';
import 'package:flutter_donation/page/dashboard/dashboard_page.dart';
import 'package:flutter_donation/page/dashboard/donation_list_page.dart';
import 'package:flutter_donation/page/dashboard/home_page.dart';
import 'package:flutter_donation/page/dashboard/my_donations_page.dart';
import 'package:flutter_donation/page/login/login_page.dart';
import 'package:flutter_donation/page/register/register_page.dart';
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
      GoRoute(
        path: '/login',
        builder: (_, __) {
          return LoginPage();
        },
      ),
      GoRoute(
        path: '/register',
        builder: (_, __) {
          return RegisterPage();
        },
      ),
    ],
  );
}
