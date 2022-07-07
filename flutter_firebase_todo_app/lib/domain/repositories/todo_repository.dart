import 'package:dartz/dartz.dart';
import 'package:flutter_firebase_todo_app/core/failures/todo_failures.dart';
import 'package:flutter_firebase_todo_app/domain/entities/auth/id.dart';
import 'package:flutter_firebase_todo_app/domain/entities/todo/todo.dart';

abstract class TodoRepository {
  Stream<Either<TodoFailure, List<Todo>>> watchAll();

  Future<Either<TodoFailure, Unit>> create(Todo todo);

  Future<Either<TodoFailure, Unit>> update(Todo todo);

  Future<Either<TodoFailure, Unit>> delete(UniqueID id);
}
