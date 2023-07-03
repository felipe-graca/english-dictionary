import 'package:english_dictionary/core/feature/words/data/models/word_model.dart';
import 'package:equatable/equatable.dart';

class WordEntity extends Equatable {
  final String word;
  final String id;

  const WordEntity({required this.word, required this.id});

  @override
  List<Object?> get props => [
        word,
        id,
      ];

  //copyWith
  WordEntity copyWith({
    final String? word,
    final String? id,
  }) {
    return WordEntity(
      word: word ?? this.word,
      id: id ?? this.id,
    );
  }

  WordModel toModel() {
    return WordModel(
      word: word,
      id: id,
    );
  }
}
