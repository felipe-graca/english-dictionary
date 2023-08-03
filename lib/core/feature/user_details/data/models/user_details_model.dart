// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart';

class UserDetailsModel extends UserDetailsEntity {
  const UserDetailsModel({
    required String uid,
    required String name,
    required String email,
    required String imagePath,
    required int countWords,
  }) : super(
          uid: uid,
          name: name,
          email: email,
          imagePath: imagePath,
          countWords: countWords,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'imagePath': imagePath,
      'countWords': countWords,
    };
  }

  factory UserDetailsModel.fromMap(Map<String, dynamic> map) {
    return UserDetailsModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      imagePath: map['imagePath'] as String,
      countWords: map['countWords'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetailsModel.fromJson(String source) => UserDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserDetailsEntity toEntity() {
    return UserDetailsEntity(
      name: name,
      email: email,
      imagePath: imagePath,
      uid: uid,
      countWords: countWords,
    );
  }
}
