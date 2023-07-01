import 'package:english_dictionary/core/feature/auth/data/model/user_data_model.dart';
import 'package:english_dictionary/core/feature/auth/data/model/word_model.dart';
import 'package:equatable/equatable.dart';

class UserDataEntity extends Equatable {
  final String name;
  final String email;
  final String base64Image;
  final String uid;
  final List<WordModel> history;

  const UserDataEntity({
    required this.name,
    required this.email,
    required this.base64Image,
    required this.uid,
    required this.history,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        base64Image,
        uid,
        history,
      ];

  //copyWith
  UserDataEntity copyWith({
    final String? name,
    final String? email,
    final String? base64Image,
    final String? uid,
    final List<WordModel>? history,
  }) {
    return UserDataEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      base64Image: base64Image ?? this.base64Image,
      uid: uid ?? this.uid,
      history: history ?? this.history,
    );
  }

  UserDataModel toModel() {
    return UserDataModel(
      name: name,
      email: email,
      base64Image: base64Image,
      uid: uid,
      history: history,
    );
  }
}
