// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:english_dictionary/core/feature/user_details/domain/entities/user_data_entity.dart';

class UserDataModel extends UserDataEntity {
  const UserDataModel({
    required String name,
    required String email,
    required String base64Image,
    required String uid,
  }) : super(name: name, email: email, base64Image: base64Image, uid: uid);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'photoUrl': base64Image,
      'uid': uid,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      name: map['name'] as String,
      email: map['email'] as String,
      base64Image: map['photoUrl'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) => UserDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserDataEntity toEntity() {
    return UserDataEntity(
      name: name,
      email: email,
      base64Image: base64Image,
      uid: uid,
    );
  }
}
