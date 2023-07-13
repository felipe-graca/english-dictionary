part of 'user_details_cubit.dart';

class UserDetailsState extends Equatable {
  final UserDetailsEntity userDetails;
  final String errorMessage;
  final bool loading;

  const UserDetailsState({
    this.userDetails = const UserDetailsEntity(),
    this.errorMessage = '',
    this.loading = false,
  });

  @override
  List<Object?> get props => [
        userDetails,
        errorMessage,
        loading,
      ];

  UserDetailsState copyWith({
    UserDetailsEntity? userDetails,
    String? errorMessage,
    bool? loading,
  }) {
    return UserDetailsState(
      userDetails: userDetails ?? this.userDetails,
      errorMessage: errorMessage ?? this.errorMessage,
      loading: loading ?? this.loading,
    );
  }
}
