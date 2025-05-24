import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_donation/bloc/campaign/campaign_cubit.dart';
import 'package:flutter_donation/bloc/category/category_cubit.dart';
import 'package:flutter_donation/bloc/slider/sliders_cubit.dart';
import 'package:flutter_donation/core/util/auth_interceptor.dart';
import 'package:flutter_donation/resource/remote/donation_remote_resource.dart';
import 'package:flutter_donation/resource/remote/home_remote_resource.dart';
import 'package:flutter_donation/resource/remote/profile_remote_resource.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_donation/app_router.dart';
import 'package:flutter_donation/bloc/auth/auth_bloc.dart';
import 'package:flutter_donation/core/constants/app_config.dart';
import 'package:flutter_donation/resource/remote/auth_remote_resource.dart';

void main() async {
  // Pastikan binding Flutter sudah diinisialisasi jika Anda melakukan operasi async sebelum runApp
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the Dio instance with base options
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiPatch,
      connectTimeout: Duration(seconds: 100),
      receiveTimeout: Duration(seconds: 100),
    ),
  );

  // Add any additional interceptors or configurations to the Dio instance here
  final authRemoteResource = AuthRemoteResource(dio);
  final homeRemoteResource = HomeRemoteResource(dio);
  final profilRemoteResource = ProfileRemoteResource(dio);
  final donationRemoteResource = DonationRemoteResource(dio);

  final authBloc = AuthBloc(authRemoteResource)
    ..add(AuthEvent.checkLoginStatus());

  final appRouter = AppRouter(
    authBloc: authBloc,
    donationRemoteResource: donationRemoteResource,
    profileRemoteResource: profilRemoteResource,
  );

  //Add the interceptor to the Dio instance
  dio.interceptors.add(AuthInterceptor(authBloc));

  runApp(
    MyApp(
      appRouter: appRouter,
      authBloc: authBloc,
      homeRemoteResource: homeRemoteResource,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final AuthBloc authBloc;
  final HomeRemoteResource homeRemoteResource;
  const MyApp({
    super.key,
    required this.appRouter,
    required this.authBloc,
    required this.homeRemoteResource,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authBloc),
        BlocProvider(create: (_) => SlidersCubit(homeRemoteResource)),
        BlocProvider(create: (_) => CategoryCubit(homeRemoteResource)),
        BlocProvider(create: (_) => CampaignCubit(homeRemoteResource)),
      ],
      child: MaterialApp.router(
        title: 'Flutter Donation',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Color(0xFFF9F5F6),
          fontFamily: GoogleFonts.poppins().fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        routerConfig: appRouter.router,
      ),
    );
  }
}
