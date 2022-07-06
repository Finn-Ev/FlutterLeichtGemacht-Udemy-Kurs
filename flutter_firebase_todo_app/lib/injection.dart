import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_todo_app/application/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter_firebase_todo_app/application/auth/signup_form/signup_form_bloc.dart';
import 'package:flutter_firebase_todo_app/domain/repositories/auth_repository.dart';
import 'package:flutter_firebase_todo_app/infrastructure/repositories/auth_repository_impl.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.I;

Future<void> init() async {
  // state management
  sl.registerFactory(() => SignUpFormBloc(authRepository: sl()));
  sl.registerFactory(() => AuthBloc(authRepository: sl()));

  // repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(firebaseAuth: sl()));

  // external
  sl.registerLazySingleton(() => FirebaseAuth.instance);
}
