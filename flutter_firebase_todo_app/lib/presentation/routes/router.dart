import 'package:auto_route/auto_route.dart';
import 'package:flutter_firebase_todo_app/presentation/home/home_page.dart';
import 'package:flutter_firebase_todo_app/presentation/signup/signup_page.dart';
import 'package:flutter_firebase_todo_app/presentation/splash/splash_page.dart';

@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: SplashPage, initial: true),
  AutoRoute(page: SignUpPage),
  AutoRoute(page: HomePage),
])
class $AppRouter {}
