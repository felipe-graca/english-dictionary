import 'dart:convert';

import 'package:english_dictionary/core/feature/word_signification/data/model/pronunciation_model.dart';
import 'package:english_dictionary/core/feature/word_signification/data/model/results_model.dart';
import 'package:english_dictionary/core/feature/word_signification/data/model/syllables_model.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/word_signification_entity.dart';

class WordSignificationModel extends WordSignificationEntity {
  const WordSignificationModel({
    String word = '',
    List<ResultsModel> results = const [],
    SyllablesModel syllables = const SyllablesModel(),
    PronunciationModel pronunciation = const PronunciationModel(),
    double frequency = 0.0,
  }) : super(word: word, results: results, syllables: syllables, pronunciation: pronunciation, frequency: frequency);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'word': word,
      'results': (results.map((x) => x.toModel()).toList()).map((e) => e.toMap()).toList(),
      'syllables': (syllables.toModel()).toMap(),
      'pronunciation': (pronunciation.toModel()).toMap(),
      'frequency': frequency,
    };
  }

  factory WordSignificationModel.fromMap(Map<String, dynamic> map) {
    return WordSignificationModel(
      word: map['word'] as String,
      results: List<ResultsModel>.from(
        (map['results'] as List<int>).map<ResultsModel>(
          (x) => ResultsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      syllables: SyllablesModel.fromMap(map['syllables'] as Map<String, dynamic>),
      pronunciation: PronunciationModel.fromMap(map['pronunciation'] as Map<String, dynamic>),
      frequency: map['frequency'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory WordSignificationModel.fromJson(String source) => WordSignificationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
