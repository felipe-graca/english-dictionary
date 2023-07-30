part of 'auth_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  final AuthStatus status;
  final String errorMessage;
  final bool loading;

  const AuthState({
    this.status = AuthStatus.unauthenticated,
    this.errorMessage = '',
    this.loading = false,
  }) : super();

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        loading,
      ];

  AuthState copyWith({
    final AuthStatus? status,
    final String? errorMessage,
    final bool? loading,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      loading: loading ?? this.loading,
    );
  }

  bool get isLogged => status == AuthStatus.authenticated;
}
