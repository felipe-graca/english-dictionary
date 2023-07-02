// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:english_dictionary/core/feature/word_signification/data/model/word_signification_model.dart';
import 'package:equatable/equatable.dart';

import 'package:english_dictionary/core/feature/word_signification/domain/entities/pronunciation_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/results_entity.dart';
import 'package:english_dictionary/core/feature/word_signification/domain/entities/syllables_entity.dart';

class WordSignificationEntity extends Equatable {
  final String word;
  final List<ResultsEntity> results;
  final SyllablesEntity syllables;
  final PronunciationEntity pronunciation;
  final double frequency;
  const WordSignificationEntity({
    this.word = '',
    this.results = const [],
    this.syllables = const SyllablesEntity(),
    this.pronunciation = const PronunciationEntity(),
    this.frequency = 0.0,
  });

  @override
  List<Object> get props {
    return [word, results, syllables, pronunciation, frequency];
  }

  WordSignificationEntity copyWith({
    String? word,
    List<ResultsEntity>? results,
    SyllablesEntity? syllables,
    PronunciationEntity? pronunciation,
    double? frequency,
  }) {
    return WordSignificationEntity(
      word: word ?? this.word,
      results: results ?? this.results,
      syllables: syllables ?? this.syllables,
      pronunciation: pronunciation ?? this.pronunciation,
      frequency: frequency ?? this.frequency,
    );
  }

  WordSignificationModel toModel() {
    return WordSignificationModel(
      word: word,
      results: results.map((e) => e.toModel()).toList(),
      syllables: syllables.toModel(),
      pronunciation: pronunciation.toModel(),
      frequency: frequency,
    );
  }
}
