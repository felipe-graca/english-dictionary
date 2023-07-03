import 'dart:convert';

import 'package:english_dictionary/core/feature/word_signification/domain/entities/exemple_entity.dart';

class ExampleModel extends ExampleEntity {
  const ExampleModel({
    String word = '',
    List<String> examples = const <String>[],
  }) : super(word: word, examples: examples);

  factory ExampleModel.fromMap(Map<String, dynamic> map) {
    return ExampleModel(
      word: map['word'] ?? '',
      examples: List<String>.from(map['examples'] ?? const <String>[]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'examples': examples,
    };
  }

  String toJson() => json.encode(toMap());

  factory ExampleModel.fromJson(String source) => ExampleModel.fromMap(json.decode(source));

  ExampleEntity toEntity() {
    return ExampleEntity(
      word: word,
      examples: examples,
    );
  }
}
