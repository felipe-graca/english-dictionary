// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:english_dictionary/core/feature/auth/data/model/word_model.dart';
import 'package:english_dictionary/core/feature/auth/domain/entities/user_data_entity.dart';

class UserDataModel {
  final String name;
  final String email;
  final String base64Image;
  final String uid;
  final List<WordModel> history;
  UserDataModel({
    required this.name,
    required this.email,
    required this.base64Image,
    required this.uid,
    required this.history,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'photoUrl': base64Image,
      'uid': uid,
      'history': history.map((x) => x.toMap()).toList(),
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      name: map['name'] as String,
      email: map['email'] as String,
      base64Image: map['photoUrl'] as String,
      uid: map['uid'] as String,
      history: List<WordModel>.from(map['history']?.map((x) => WordModel.fromMap(x as Map<String, dynamic>)) as Iterable<dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDataModel.fromJson(String source) => UserDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  //fromEntity
  factory UserDataModel.fromEntity(UserDataEntity entity) {
    return UserDataModel(
      name: entity.name,
      email: entity.email,
      base64Image: entity.base64Image,
      uid: entity.uid,
      history: entity.history,
    );
  }
}
