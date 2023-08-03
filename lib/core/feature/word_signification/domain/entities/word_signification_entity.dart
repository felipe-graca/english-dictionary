// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class WordSignificationEntity extends Equatable {
  final String word;
  final String definition;
  final String example;
  final String pronunciation;
  const WordSignificationEntity({
    this.word = '',
    this.definition = '',
    this.example = '',
    this.pronunciation = '',
  });

  @override
  List<Object> get props => [word, definition, example, pronunciation];

  WordSignificationEntity copyWith({
    String? word,
    String? definition,
    String? example,
    String? pronunciation,
  }) {
    return WordSignificationEntity(
      word: word ?? this.word,
      definition: definition ?? this.definition,
      example: example ?? this.example,
      pronunciation: pronunciation ?? this.pronunciation,
    );
  }

  bool get isEmpty => word.isEmpty && definition.isEmpty && example.isEmpty && pronunciation.isEmpty;
}
