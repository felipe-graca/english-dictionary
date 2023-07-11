// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';

class UserDetailsModel extends UserDetailsEntity {
  const UserDetailsModel({
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

  factory UserDetailsModel.fromMap(Map<String, dynamic> map) {
    return UserDetailsModel(
      name: map['name'] as String,
      email: map['email'] as String,
      base64Image: map['photoUrl'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetailsModel.fromJson(String source) => UserDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserDetailsEntity toEntity() {
    return UserDetailsEntity(
      name: name,
      email: email,
      base64Image: base64Image,
      uid: uid,
    );
  }
}
