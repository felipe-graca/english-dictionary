// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:english_dictionary/core/feature/word_signification/data/model/results_model.dart';
import 'package:equatable/equatable.dart';

class ResultsEntity extends Equatable {
  final String definition;
  final String partOfSpeech;
  final List<String> synonyms;
  final List<String> typeOf;
  final List<String> hasTypes;
  final List<String> derivation;
  final List<String> examples;
  const ResultsEntity({
    this.definition = '',
    this.partOfSpeech = '',
    this.synonyms = const [],
    this.typeOf = const [],
    this.hasTypes = const [],
    this.derivation = const [],
    this.examples = const [],
  });

  @override
  List<Object> get props {
    return [definition, partOfSpeech, synonyms, typeOf, hasTypes, derivation, examples];
  }

  ResultsEntity copyWith({
    String? definition,
    String? partOfSpeech,
    List<String>? synonyms,
    List<String>? typeOf,
    List<String>? hasTypes,
    List<String>? derivation,
    List<String>? examples,
  }) {
    return ResultsEntity(
      definition: definition ?? this.definition,
      partOfSpeech: partOfSpeech ?? this.partOfSpeech,
      synonyms: synonyms ?? this.synonyms,
      typeOf: typeOf ?? this.typeOf,
      hasTypes: hasTypes ?? this.hasTypes,
      derivation: derivation ?? this.derivation,
      examples: examples ?? this.examples,
    );
  }

  ResultsModel toModel() {
    return ResultsModel(
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
