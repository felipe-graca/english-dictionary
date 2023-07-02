import 'dart:convert';

import 'package:english_dictionary/core/feature/word_signification/domain/entities/pronunciation_entity.dart';

class PronunciationModel extends PronunciationEntity {
  const PronunciationModel({
    String adjective = '',
    String adverb = '',
    String all = '',
    String noun = '',
    String verb = '',
  }) : super(adjective: adjective, adverb: adverb, all: all, noun: noun, verb: verb);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adjective': adjective,
      'adverb': adverb,
      'all': all,
      'noun': noun,
      'verb': verb,
    };
  }

  factory PronunciationModel.fromMap(Map<String, dynamic> map) {
    return PronunciationModel(
      adjective: map['adjective'] as String,
      adverb: map['adverb'] as String,
      all: map['all'] as String,
      noun: map['noun'] as String,
      verb: map['verb'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PronunciationModel.fromJson(String source) => PronunciationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PronunciationEntity toEntity() {
    return PronunciationEntity(
      adjective: adjective,
      adverb: adverb,
      all: all,
      noun: noun,
      verb: verb,
    );
  }
}
