import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_todo_app/domain/entities/id.dart';
import 'package:flutter_firebase_todo_app/domain/entities/user.dart';

extension FirebaseUserMapper on User {
  CustomUser toCustomUser() {
    return CustomUser(id: UniqueID.fromString(uid));
  }
}
