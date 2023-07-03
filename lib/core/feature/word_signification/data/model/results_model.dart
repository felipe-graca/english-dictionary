import 'dart:convert';

import 'package:english_dictionary/core/feature/word_signification/domain/entities/results_entity.dart';

class ResultsModel extends ResultsEntity {
  const ResultsModel({
    String definition = '',
    String partOfSpeech = '',
    List<String> synonyms = const [],
    List<String> typeOf = const [],
    List<String> hasTypes = const [],
    List<String> derivation = const [],
    List<String> examples = const [],
  }) : super(
          definition: definition,
          partOfSpeech: partOfSpeech,
          synonyms: synonyms,
          typeOf: typeOf,
          hasTypes: hasTypes,
          derivation: derivation,
          examples: examples,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'definition': definition,
      'partOfSpeech': partOfSpeech,
      'synonyms': synonyms,
      'typeOf': typeOf,
      'hasTypes': hasTypes,
      'derivation': derivation,
      'examples': examples,
    };
  }

  factory ResultsModel.fromMap(Map<String, dynamic> map) {
    return ResultsModel(
      definition: map['definition'] ?? '',
      partOfSpeech: map['partOfSpeech'] ?? '',
      synonyms: List<String>.from(map['synonyms'] ?? <String>[]),
      typeOf: List<String>.from(map['typeOf'] ?? <dynamic>[]),
      hasTypes: List<String>.from(map['hasTypes'] ?? <dynamic>[]),
      derivation: List<String>.from(map['derivation'] ?? <String>[]),
      examples: List<String>.from(map['examples'] ?? <String>[]),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultsModel.fromJson(String source) => ResultsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ResultsEntity toEntity() {
    return ResultsEntity(
      definition: definition,
      partOfSpeech: partOfSpeech,
      synonyms: synonyms,
      typeOf: typeOf,
      hasTypes: hasTypes,
      derivation: derivation,
      examples: examples,
    );
  }
}
