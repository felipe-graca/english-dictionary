// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:english_dictionary/core/feature/history/domain/entities/history_word_entity.dart';

class HistoryWordModel extends HistoryWordEntity {
  const HistoryWordModel({
    required String id,
    required String word,
  }) : super(id: id, word: word);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'word': word,
    };
  }

  factory HistoryWordModel.fromMap(Map<String, dynamic> map) {
    return HistoryWordModel(
      id: map['id'] as String,
      word: map['word'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryWordModel.fromJson(String source) => HistoryWordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  HistoryWordEntity toEntity() {
    return HistoryWordEntity(
      id: id,
      word: word,
    );
  }
}
