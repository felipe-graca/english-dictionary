// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart';

class FavoriteWordModel extends FavoriteWordEntity {
  const FavoriteWordModel({
    required String word,
    required String id,
  }) : super(word: word, id: id);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'word': word,
      'id': id,
    };
  }

  factory FavoriteWordModel.fromMap(Map<String, dynamic> map) {
    return FavoriteWordModel(
      word: map['word'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteWordModel.fromJson(String source) => FavoriteWordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  FavoriteWordEntity toEntity() {
    return FavoriteWordEntity(
      word: word,
      id: id,
    );
  }
}
