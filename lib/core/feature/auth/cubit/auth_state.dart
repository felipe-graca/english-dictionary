part of 'auth_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  final User? userAuthDetails;
  final AuthStatus status;
  const AuthState({
    this.userAuthDetails,
    this.status = AuthStatus.unauthenticated,
  }) : super();

  @override
  List<Object?> get props => [
        userAuthDetails,
        status,
      ];

  AuthState copyWith({
    final User? Function()? userAuthDetails,
    final AuthStatus? status,
  }) {
    return AuthState(
      userAuthDetails: userAuthDetails != null ? userAuthDetails() : this.userAuthDetails,
      status: status ?? this.status,
    );
  }

  bool get isLogged => status == AuthStatus.authenticated;
}
