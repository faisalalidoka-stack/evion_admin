import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  late final StreamSubscription<User?> _subscription;

  AuthCubit(this.repository) : super(const AuthState()) {
    _subscription = repository.authStateChanges().listen(_onAuthChanged);
  }

  Future<void> _onAuthChanged(User? user) async {
    if (user == null) {
      emit(state.copyWith(status: AuthStatus.unauthenticated, clearError: true));
      return;
    }

    final isAdmin = await repository.isAdmin(user);

    if (!isAdmin) {
      await repository.signOut();
      emit(
        const AuthState(
          status: AuthStatus.unauthenticated,
          errorMessage: "This account does not have admin access.",
        ),
      );
      return;
    }

    emit(
      AuthState(
        status: AuthStatus.authenticated,
        email: user.email,
      ),
    );
  }

  Future<void> signIn(String email, String password) async {
    emit(state.copyWith(submitting: true, clearError: true));
    try {
      await repository.signIn(email, password);
      // authStateChanges listener above picks up the result.
    } catch (e) {
      emit(
        state.copyWith(
          submitting: false,
          errorMessage: repository.friendlyError(e),
        ),
      );
    }
  }

  Future<void> signOut() => repository.signOut();

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}