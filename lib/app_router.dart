import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/bloc/auth/auth_bloc.dart';
import 'package:flutter_donation/bloc/campaign/campaign_cubit.dart';
import 'package:flutter_donation/bloc/donate/donate_cubit.dart';
import 'package:flutter_donation/bloc/donation/donation_cubit.dart';
import 'package:flutter_donation/bloc/profile/profile_cubit.dart';
import 'package:flutter_donation/core/animation/custom_fade_page.dart';
import 'package:flutter_donation/page/campaign/detail_campaign_page.dart';
import 'package:flutter_donation/page/dashboard/account_page.dart';
import 'package:flutter_donation/page/dashboard/dashboard_page.dart';
import 'package:flutter_donation/page/dashboard/campaign_list_page.dart';
import 'package:flutter_donation/page/dashboard/home_page.dart';
import 'package:flutter_donation/page/dashboard/my_donations_page.dart';
import 'package:flutter_donation/page/donate/donate_page.dart';
import 'package:flutter_donation/page/login/login_page.dart';
import 'package:flutter_donation/page/payment/midtrans_payment_page.dart';
import 'package:flutter_donation/page/profile/update_password_page.dart';
import 'package:flutter_donation/page/profile/update_profile_page.dart';
import 'package:flutter_donation/page/register/register_page.dart';
import 'package:flutter_donation/page/search/search_page.dart';
import 'package:flutter_donation/resource/remote/donation_remote_resource.dart';
import 'package:flutter_donation/resource/remote/home_remote_resource.dart';
import 'package:flutter_donation/resource/remote/profile_remote_resource.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final AuthBloc authBloc;
  final ProfileRemoteResource profileRemoteResource;
  final DonationRemoteResource donationRemoteResource;
  final HomeRemoteResource homeRemoteResource;

  AppRouter({
    required this.authBloc,
    required this.profileRemoteResource,
    required this.donationRemoteResource,
    required this.homeRemoteResource,
  });

  late final GoRouter router = GoRouter(
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    initialLocation: '/dashboard/home',
    redirect: (context, state) {
      final authState = authBloc.state;
      final isLoggedIn = authState is Authenticated;

      final protectedRoutes = ['/dashboard/my_donations', '/dashboard/account'];

      final isProtected = protectedRoutes.any(
        (route) => state.matchedLocation.startsWith(route),
      );

      if (!isLoggedIn && isProtected) return '/login';

      if (isLoggedIn && state.matchedLocation == '/login') {
        return '/login';
      }

      return null;
    },
    routes: [
      ShellRoute(
        builder: (_, _, child) => DashboardPage(child: child),
        routes: [
          GoRoute(
            path: '/dashboard/home',
            pageBuilder:
                (context, state) =>
                    CustomFadePage(child: HomePage(), key: state.pageKey),
          ),
          GoRoute(
            path: '/dashboard/campaign_list',
            pageBuilder:
                (context, state) => CustomFadePage(
                  child: CampaignListPage(),
                  key: state.pageKey,
                ),
          ),
          GoRoute(
            path: '/dashboard/my_donations',
            pageBuilder:
                (context, state) => CustomFadePage(
                  child: BlocProvider(
                    create: (context) => DonationCubit(donationRemoteResource),
                    child: MyDonationsPage(),
                  ),
                  key: state.pageKey,
                ),
          ),
          GoRoute(
            path: '/dashboard/account',
            pageBuilder:
                (context, state) => CustomFadePage(
                  child: BlocProvider(
                    create: (context) => ProfileCubit(profileRemoteResource),
                    child: AccountPage(),
                  ),
                  key: state.pageKey,
                ),
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
      GoRoute(
        path: '/update_profile',
        pageBuilder: (context, state) {
          return CustomFadePage(
            child: BlocProvider(
              create: (context) => ProfileCubit(profileRemoteResource),
              child: UpdateProfilePage(),
            ),
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/update_password',
        pageBuilder: (context, state) {
          return CustomFadePage(
            child: BlocProvider(
              create: (context) => ProfileCubit(profileRemoteResource),
              child: UpdatePasswordPage(),
            ),
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/detail_campaign/:slug',
        pageBuilder: (context, state) {
          return CustomFadePage(
            child: BlocProvider(
              create:
                  (context) =>
                      CampaignCubit(homeRemoteResource)
                        ..getDetailCampaign(state.pathParameters['slug'] ?? ''),
              child: DetailCampaignPage(),
            ),
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/donate/:slug',
        pageBuilder: (context, state) {
          return CustomFadePage(
            child: BlocProvider(
              create: (context) => DonateCubit(donationRemoteResource),
              child: DonatePage(
                slugCampaign: state.pathParameters['slug'] ?? '',
              ),
            ),
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/payment/:snapToken',
        pageBuilder: (context, state) {
          return CustomFadePage(
            child: MidtransPaymentPage(
              snapToken: state.pathParameters['snapToken'] ?? '',
            ),
            key: state.pageKey,
          );
        },
      ),
      GoRoute(
        path: '/search/:query',
        pageBuilder: (context, state) {
          return CustomFadePage(
            child: BlocProvider(
              create:
                  (context) =>
                      CampaignCubit(homeRemoteResource)
                        ..searchCampaigns(state.pathParameters['query'] ?? ''),
              child: SearchPage(),
            ),
            key: state.pageKey,
          );
        },
      ),
    ],
  );
}

// Helper untuk konversi Bloc stream ke Listenable
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream stream) {
    stream.listen((_) {
      notifyListeners();
    });
  }
}
