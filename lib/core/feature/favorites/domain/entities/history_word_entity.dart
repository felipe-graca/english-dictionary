import 'package:english_dictionary/core/feature/words/data/models/word_model.dart';
import 'package:equatable/equatable.dart';

class HistoryWordEntity extends Equatable {
  final String word;
  final String id;

  const HistoryWordEntity({this.word = '', this.id = ''});

  @override
  List<Object?> get props => [
        word,
        id,
      ];

  //copyWith
  HistoryWordEntity copyWith({
    final String? word,
    final String? id,
  }) {
    return HistoryWordEntity(
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
