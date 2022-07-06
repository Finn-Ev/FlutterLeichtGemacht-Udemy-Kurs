part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SignOutButtonPressed extends AuthEvent {}

class AuthStateAuthenticated extends AuthState {}

class AuthCheckRequested extends AuthEvent {}
