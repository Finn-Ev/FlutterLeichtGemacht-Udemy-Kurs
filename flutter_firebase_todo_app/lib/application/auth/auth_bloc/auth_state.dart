part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthUnauthenticatedState extends AuthState {}
