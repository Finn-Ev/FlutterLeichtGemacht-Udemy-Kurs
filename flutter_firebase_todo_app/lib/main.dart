import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_todo_app/application/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter_firebase_todo_app/firebase_options.dart';
import 'package:flutter_firebase_todo_app/presentation/routes/router.gr.dart' as router;
import 'package:flutter_firebase_todo_app/theme.dart';

import 'injection.dart' as di;
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding?.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final appRouter = router.AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>()..add(AuthCheckRequested()),
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: appRouter.defaultRouteParser(),
        routerDelegate: appRouter.delegate(),
        debugShowCheckedModeBanner: false,
        title: 'Fireflutter Todo',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
