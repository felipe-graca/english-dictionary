import 'package:english_dictionary/core/feature/history/data/models/history_word_model.dart';
import 'package:english_dictionary/core/feature/user_details/data/models/user_data_model.dart';
import 'package:equatable/equatable.dart';

class UserDataEntity extends Equatable {
  final String name;
  final String email;
  final String base64Image;
  final String uid;

  const UserDataEntity({
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
  UserDataEntity copyWith({
    final String? name,
    final String? email,
    final String? base64Image,
    final String? uid,
    final List<HistoryWordModel>? history,
  }) {
    return UserDataEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      base64Image: base64Image ?? this.base64Image,
      uid: uid ?? this.uid,
    );
  }

  UserDataModel toModel() {
    return UserDataModel(
      name: name,
      email: email,
      base64Image: base64Image,
      uid: uid,
    );
  }

  //isEmty
  bool get isEmpty => name.isEmpty && email.isEmpty && base64Image.isEmpty && uid.isEmpty;
}
