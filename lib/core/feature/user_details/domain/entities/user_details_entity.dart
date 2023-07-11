import 'package:english_dictionary/core/feature/history/data/models/history_word_model.dart';
import 'package:english_dictionary/core/feature/user_details/data/models/user_details_model.dart';
import 'package:equatable/equatable.dart';

class UserDetailsEntity extends Equatable {
  final String name;
  final String email;
  final String base64Image;
  final String uid;

  const UserDetailsEntity({
    this.name = '',
    this.email = '',
    this.base64Image = '',
    this.uid = '',
  });

  @override
  List<Object?> get props => [
        name,
        email,
        base64Image,
        uid,
      ];

  //copyWith
  UserDetailsEntity copyWith({
    final String? name,
    final String? email,
    final String? base64Image,
    final String? uid,
    final List<HistoryWordModel>? history,
  }) {
    return UserDetailsEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      base64Image: base64Image ?? this.base64Image,
      uid: uid ?? this.uid,
    );
  }

  UserDetailsModel toModel() {
    return UserDetailsModel(
      name: name,
      email: email,
      base64Image: base64Image,
      uid: uid,
    );
  }

  //isEmty
  bool get isEmpty => name.isEmpty && email.isEmpty && base64Image.isEmpty && uid.isEmpty;
}
