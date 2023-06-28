part of 'auth_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  final User? currentUser;
  final AuthStatus status;
  const AuthState({
    this.currentUser,
    this.status = AuthStatus.unauthenticated,
  }) : super();

  @override
  List<Object?> get props => [
        currentUser,
        status,
      ];

  AuthState copyWith({
    final User? currentUser,
    final AuthStatus? status,
  }) {
    return AuthState(
      currentUser: currentUser ?? this.currentUser,
      status: status ?? this.status,
    );
  }

  bool get isLogged => status == AuthStatus.authenticated;
}
