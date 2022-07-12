import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_todo_app/application/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter_firebase_todo_app/application/auth/signup_form/signup_form_bloc.dart';
import 'package:flutter_firebase_todo_app/application/todos/controller/todos_controller_bloc.dart';
import 'package:flutter_firebase_todo_app/application/todos/detail_form/todo_detail_form_bloc.dart';
import 'package:flutter_firebase_todo_app/application/todos/oberserver/todos_observer_bloc.dart';
import 'package:flutter_firebase_todo_app/domain/repositories/auth_repository.dart';
import 'package:flutter_firebase_todo_app/domain/repositories/todo_repository.dart';
import 'package:flutter_firebase_todo_app/infrastructure/repositories/auth_repository_impl.dart';
import 'package:flutter_firebase_todo_app/infrastructure/repositories/todo_repository_impl.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.I;

Future<void> init() async {
  // Auth
  // state management
  sl.registerFactory(() => SignUpFormBloc(authRepository: sl()));
  sl.registerFactory(() => AuthBloc(authRepository: sl()));

  // repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(firebaseAuth: sl()));

  // external
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  //# Todo
  // state management
  sl.registerFactory(() => TodosObserverBloc(todoRepository: sl()));
  sl.registerFactory(() => TodosControllerBloc(todoRepository: sl()));
  sl.registerFactory(() => TodoDetailFormBloc(todoRepository: sl()));

  // repositories
  sl.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(firestore: sl()));

  // external
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
