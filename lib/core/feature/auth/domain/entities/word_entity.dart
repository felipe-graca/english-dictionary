import 'package:english_dictionary/core/feature/auth/data/model/word_model.dart';
import 'package:equatable/equatable.dart';

class WordEntity extends WordModel with EquatableMixin {
  WordEntity({required super.word, required super.uid});

  @override
  List<Object?> get props => [
        super.word,
        super.uid,
      ];

  //copyWith
  WordEntity copyWith({
    final String? word,
    final String? uid,
  }) {
    return WordEntity(
      word: word ?? super.word,
      uid: uid ?? super.uid,
    );
  }

  //factory fromModel
  factory WordEntity.fromModel(WordModel model) {
    return WordEntity(
      word: model.word,
      uid: model.uid,
    );
  }
}
