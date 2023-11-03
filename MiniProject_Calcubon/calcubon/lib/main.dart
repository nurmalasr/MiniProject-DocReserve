import 'package:calcubon/blocs/user/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'blocs/report/report_bloc.dart';
import 'services/report_service.dart';
import 'utils/colors.dart';
import 'views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'views/main_page.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/',
        name: 'main_page',
        builder: (context, state) => MainPage(),
      ),
    ],
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routerNeglect: true,
  );
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc()..add(CheckSignInStatus()),
        ),
        BlocProvider(
          create: (context) =>
              ReportBloc(reportService: ReportService())..add(LoadReport()),
        ),
      ],
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserSignedIn) {
            router.goNamed('main_page');
          } else if (state is UserSignedOut) {
            router.goNamed('login');
          }
        },
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          routeInformationProvider: router.routeInformationProvider,
          theme: ThemeData(primaryColor: primaryColor),
          title: 'Calcubon',
        ),
      ),
    );
  }
}
