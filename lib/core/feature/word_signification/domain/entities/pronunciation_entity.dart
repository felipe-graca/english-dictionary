// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:english_dictionary/core/feature/word_signification/data/model/pronunciation_model.dart';
import 'package:equatable/equatable.dart';

class PronunciationEntity extends Equatable {
  final String all;
  final String noun;
  final String verb;
  final String adjective;
  final String adverb;

  const PronunciationEntity({
    this.all = '',
    this.noun = '',
    this.verb = '',
    this.adjective = '',
    this.adverb = '',
  });

  @override
  List<Object?> get props => [all, noun, verb, adjective, adverb];

  PronunciationEntity copyWith({
    String? all,
    String? noun,
    String? verb,
    String? adjective,
    String? adverb,
  }) {
    return PronunciationEntity(
      all: all ?? this.all,
      noun: noun ?? this.noun,
      verb: verb ?? this.verb,
      adjective: adjective ?? this.adjective,
      adverb: adverb ?? this.adverb,
    );
  }

  PronunciationModel toModel() {
    return PronunciationModel(
      all: all,
      noun: noun,
      verb: verb,
      adjective: adjective,
      adverb: adverb,
    );
  }

  bool get isEmpty => all.isEmpty && noun.isEmpty && verb.isEmpty && adjective.isEmpty && adverb.isEmpty;
}
