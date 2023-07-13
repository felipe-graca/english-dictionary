part of 'auth_cubit.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  final User? userAuthDetails;
  final AuthStatus status;
  final String errorMessage;
  final bool loading;

  const AuthState({
    this.userAuthDetails,
    this.status = AuthStatus.unauthenticated,
    this.errorMessage = '',
    this.loading = false,
  }) : super();

  @override
  List<Object?> get props => [
        userAuthDetails,
        status,
        errorMessage,
        loading,
      ];

  AuthState copyWith({
    final User? Function()? userAuthDetails,
    final AuthStatus? status,
    final String? errorMessage,
    final bool? loading,
  }) {
    return AuthState(
      userAuthDetails: userAuthDetails != null ? userAuthDetails() : this.userAuthDetails,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      loading: loading ?? this.loading,
    );
  }

  bool get isLogged => status == AuthStatus.authenticated;
}
