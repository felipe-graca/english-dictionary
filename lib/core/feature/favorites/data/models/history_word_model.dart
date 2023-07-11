// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:english_dictionary/core/feature/favorites/domain/entities/history_word_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/word_entity.dart';

class HistoryWordModel extends HistoryWordEntity {
  const HistoryWordModel({
    required String word,
    required String id,
  }) : super(word: word, id: id);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'word': word,
      'id': id,
    };
  }

  factory HistoryWordModel.fromMap(Map<String, dynamic> map) {
    return HistoryWordModel(
      word: map['word'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryWordModel.fromJson(String source) => HistoryWordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  WordEntity toEntity() {
    return WordEntity(
      word: word,
      id: id,
    );
  }
}
