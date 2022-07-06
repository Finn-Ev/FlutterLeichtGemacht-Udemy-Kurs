import 'package:bloc/bloc.dart';
import 'package:flutter_firebase_todo_app/domain/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

part './auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitialState()) {
    on<SignOutButtonPressed>((event, emit) async {
      await authRepository.signOut();
      emit(AuthUnauthenticatedState());
    });
    on<AuthCheckRequested>((event, emit) {
      final userOption = authRepository.getSignedInUser();
      userOption.fold(
        () => emit(AuthUnauthenticatedState()), // userOption is "none()", no user signed in
        (user) => emit(AuthStateAuthenticated()),
      );
    });
  }
}
