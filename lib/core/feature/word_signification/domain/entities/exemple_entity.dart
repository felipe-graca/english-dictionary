// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:english_dictionary/core/feature/word_signification/data/model/exemple_model.dart';
import 'package:equatable/equatable.dart';

class ExampleEntity extends Equatable {
  final String word;
  final List<String> examples;

  const ExampleEntity({
    this.word = '',
    this.examples = const <String>[],
  });

  @override
  List<Object> get props => [word, examples];

  ExampleEntity copyWith({
    String? word,
    List<String>? examples,
  }) {
    return ExampleEntity(
      word: word ?? this.word,
      examples: examples ?? this.examples,
    );
  }

  ExampleModel toModel() {
    return ExampleModel(
      word: word,
      examples: examples,
    );
  }

  bool get isEmpty => word.isEmpty && examples.isEmpty;
}
