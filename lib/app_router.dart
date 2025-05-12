import 'package:flutter_donation/core/animation/custom_fade_page.dart';
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
            pageBuilder:
                (context, state) =>
                    CustomFadePage(child: HomePage(), key: state.pageKey),
          ),
          GoRoute(
            path: '/dashboard/donation_list',
            pageBuilder:
                (context, state) => CustomFadePage(
                  child: DonationListPage(),
                  key: state.pageKey,
                ),
          ),
          GoRoute(
            path: '/dashboard/my_donations',
            pageBuilder:
                (context, state) => CustomFadePage(
                  child: MyDonationsPage(),
                  key: state.pageKey,
                ),
          ),
          GoRoute(
            path: '/dashboard/account',
            pageBuilder:
                (context, state) =>
                    CustomFadePage(child: AccountPage(), key: state.pageKey),
          ),
        ],
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return CustomFadePage(child: LoginPage(), key: state.pageKey);
        },
      ),
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) {
          return CustomFadePage(child: RegisterPage(), key: state.pageKey);
        },
      ),
    ],
  );
}
