enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final String? email;
  final String? errorMessage;
  final bool submitting;

  const AuthState({
    this.status = AuthStatus.unknown,
    this.email,
    this.errorMessage,
    this.submitting = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? email,
    String? errorMessage,
    bool clearError = false,
    bool? submitting,
  }) {
    return AuthState(
      status: status ?? this.status,
      email: email ?? this.email,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      submitting: submitting ?? this.submitting,
    );
  }
}