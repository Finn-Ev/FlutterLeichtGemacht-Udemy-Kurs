import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_todo_app/core/errors/errors.dart';
import 'package:flutter_firebase_todo_app/domain/entities/auth/id.dart';
import 'package:flutter_firebase_todo_app/domain/entities/auth/user.dart';
import 'package:flutter_firebase_todo_app/domain/repositories/auth_repository.dart';
import 'package:flutter_firebase_todo_app/injection.dart';

extension FirebaseUserMapper on User {
  CustomUser toCustomUser() {
    return CustomUser(id: UniqueID.fromString(uid));
  }
}

extension FirestoreExt on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    return FirebaseFirestore.instance.collection("users").doc(user.id.value);
  }
}

extension DocumentReferenceExt on DocumentReference {
  CollectionReference<Map<String, dynamic>> get todoCollection => collection("todos");
}
