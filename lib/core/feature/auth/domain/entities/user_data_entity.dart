import 'package:english_dictionary/core/feature/auth/data/model/user_data_model.dart';
import 'package:english_dictionary/core/feature/auth/data/model/word_model.dart';
import 'package:equatable/equatable.dart';

class UserDataEntity extends UserDataModel with EquatableMixin {
  UserDataEntity({required super.name, required super.email, required super.base64Image, required super.uid, required super.history});

  @override
  List<Object?> get props => [
        super.name,
        super.email,
        super.base64Image,
        super.uid,
        super.history,
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
      name: name ?? super.name,
      email: email ?? super.email,
      base64Image: base64Image ?? super.base64Image,
      uid: uid ?? super.uid,
      history: history ?? super.history,
    );
  }

  //factory fromModel
  factory UserDataEntity.fromModel(UserDataModel model) {
    return UserDataEntity(
      name: model.name,
      email: model.email,
      base64Image: model.base64Image,
      uid: model.uid,
      history: model.history,
    );
  }
}
