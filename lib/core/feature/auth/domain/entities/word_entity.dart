import 'package:english_dictionary/core/feature/auth/data/model/word_model.dart';
import 'package:equatable/equatable.dart';

class WordEntity extends Equatable {
  final String word;
  final String uid;

  const WordEntity({required this.word, required this.uid});

  @override
  List<Object?> get props => [
        word,
        uid,
      ];

  //copyWith
  WordEntity copyWith({
    final String? word,
    final String? uid,
  }) {
    return WordEntity(
      word: word ?? this.word,
      uid: uid ?? this.uid,
    );
  }

  WordModel toModel() {
    return WordModel(
      word: word,
      uid: uid,
    );
  }
}