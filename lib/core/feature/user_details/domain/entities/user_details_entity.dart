import 'package:english_dictionary/core/feature/history/data/models/history_word_model.dart';
import 'package:english_dictionary/core/feature/user_details/data/models/user_details_model.dart';
import 'package:equatable/equatable.dart';

class UserDetailsEntity extends Equatable {
  final String uid;
  final String name;
  final String email;
  final String base64Image;
  final int countWords;

  const UserDetailsEntity({
    this.uid = '',
    this.name = '',
    this.email = '',
    this.base64Image = '',
    this.countWords = 0,
  });

  @override
  List<Object?> get props => [
        uid,
        name,
        email,
        base64Image,
        countWords,
      ];

  //copyWith
  UserDetailsEntity copyWith({
    final String? uid,
    final String? name,
    final String? email,
    final String? base64Image,
    final List<HistoryWordModel>? history,
    final int? countWords,
  }) {
    return UserDetailsEntity(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      base64Image: base64Image ?? this.base64Image,
      countWords: countWords ?? this.countWords,
    );
  }

  UserDetailsModel toModel() {
    return UserDetailsModel(
      uid: uid,
      name: name,
      email: email,
      base64Image: base64Image,
      countWords: countWords,
    );
  }

  //isEmty
  bool get isEmpty => name.isEmpty && email.isEmpty && base64Image.isEmpty && uid.isEmpty;
}
