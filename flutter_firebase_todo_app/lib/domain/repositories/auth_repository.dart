import 'package:dartz/dartz.dart';
import 'package:flutter_firebase_todo_app/core/failures/auth_failures.dart';
import 'package:flutter_firebase_todo_app/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Option<CustomUser> getSignedInUser();
}
