// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:english_dictionary/core/feature/auth/domain/entities/word_entity.dart';

class WordModel {
  final String word;
  final String uid;

  WordModel({
    required this.word,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'word': word,
      'uid': uid,
    };
  }

  factory WordModel.fromMap(Map<String, dynamic> map) {
    return WordModel(
      word: map['word'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WordModel.fromJson(String source) => WordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  //fromEntity
  factory WordModel.fromEntity(WordEntity entity) {
    return WordModel(
      word: entity.word,
      uid: entity.uid,
    );
  }
}
