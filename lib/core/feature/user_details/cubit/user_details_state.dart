part of 'user_details_cubit.dart';

class UserDetailsState extends Equatable {
  final UserDetailsEntity? userDetails;
  final String errorMessage;
  final bool wasSubmitted;

  const UserDetailsState({
    this.userDetails = const UserDetailsEntity(),
    this.errorMessage = '',
    this.wasSubmitted = false,
  });

  @override
  List<Object?> get props => [
        userDetails,
        errorMessage,
        wasSubmitted,
      ];

  UserDetailsState copyWith({
    UserDetailsEntity? userDetails,
    String? errorMessage,
    bool? wasSubmitted,
  }) {
    return UserDetailsState(
      userDetails: userDetails ?? this.userDetails,
      errorMessage: errorMessage ?? this.errorMessage,
      wasSubmitted: wasSubmitted ?? this.wasSubmitted,
    );
  }
}
