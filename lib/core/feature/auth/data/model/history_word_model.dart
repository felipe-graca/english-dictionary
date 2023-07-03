// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:english_dictionary/core/feature/auth/domain/entities/history_word_entity.dart';

class HistoryWordModel extends HistoryWordEntity {
  const HistoryWordModel({
    required String word,
    required String uid,
  }) : super(word: word, uid: uid);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'word': word,
      'uid': uid,
    };
  }

  factory HistoryWordModel.fromMap(Map<String, dynamic> map) {
    return HistoryWordModel(
      word: map['word'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryWordModel.fromJson(String source) => HistoryWordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  HistoryWordEntity toEntity() {
    return HistoryWordEntity(
      word: word,
      uid: uid,
    );
  }
}
