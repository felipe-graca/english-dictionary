// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';

class WordModel extends WordEntity {
  const WordModel({
    required String word,
    required String id,
  }) : super(word: word, id: id);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'word': word,
      'id': id,
    };
  }

  factory WordModel.fromMap(Map<String, dynamic> map) {
    return WordModel(
      word: map['word'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WordModel.fromJson(String source) => WordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  WordEntity toEntity() {
    return WordEntity(
      word: word,
      id: id,
    );
  }
}
