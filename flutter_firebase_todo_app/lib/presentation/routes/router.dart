import 'package:auto_route/auto_route.dart';
import 'package:flutter_firebase_todo_app/presentation/home/home_page.dart';
import 'package:flutter_firebase_todo_app/presentation/signup/signup_page.dart';
import 'package:flutter_firebase_todo_app/presentation/splash/splash_page.dart';
import 'package:flutter_firebase_todo_app/presentation/todo_detail/todo_detail_page.dart';

// run ❯ flutter packages pub run build_runner build
@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: SplashPage, initial: true),
  AutoRoute(page: SignUpPage),
  AutoRoute(page: HomePage),
  AutoRoute(page: TodoDetailPage, fullscreenDialog: true),
])
class $AppRouter {}
