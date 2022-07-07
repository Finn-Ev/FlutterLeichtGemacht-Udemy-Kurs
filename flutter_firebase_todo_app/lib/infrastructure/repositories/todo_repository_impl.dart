import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_firebase_todo_app/core/failures/todo_failures.dart';
import 'package:flutter_firebase_todo_app/domain/entities/auth/id.dart';
import 'package:flutter_firebase_todo_app/domain/entities/todo/todo.dart';
import 'package:flutter_firebase_todo_app/domain/repositories/todo_repository.dart';
import 'package:flutter_firebase_todo_app/infrastructure/extensions/firebase_helpers.dart';
import 'package:flutter_firebase_todo_app/infrastructure/models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final FirebaseFirestore firestore;
  TodoRepositoryImpl({required this.firestore});

  @override
  Future<Either<TodoFailure, Unit>> create(Todo todo) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<TodoFailure, Unit>> delete(UniqueID id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<TodoFailure, Unit>> update(Todo todo) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<Either<TodoFailure, List<Todo>>> watchAll() async* {
    final userDoc = await firestore.userDocument();

    // right side listen on todos
    yield* userDoc.todoCollection
        .snapshots()
        .map((snapshot) =>
            right<TodoFailure, List<Todo>>(snapshot.docs.map((doc) => TodoModel.fromFirestore(doc).toEntity()).toList()))
        .handleError((e) {
      if (e is FirebaseException) {
        if (e.code.contains('permission-denied') || e.code.contains("PERMISSION_DENIED")) {
          return left(InsufficientPermissions());
        } else {
          return left(UnexpectedFailure());
        }
      } else {
        return left(UnexpectedFailure());
      }
    });
  }
}
