import 'package:english_dictionary/core/feature/history/data/models/history_word_model.dart';
import 'package:equatable/equatable.dart';

class HistoryWordEntity extends Equatable {
  final String id;
  final String word;

  const HistoryWordEntity({
    this.id = '',
    this.word = '',
  });

  @override
  List<Object?> get props => [
        id,
        word,
      ];

  //copyWith
  HistoryWordEntity copyWith({
    final String? word,
    final String? id,
  }) {
    return HistoryWordEntity(
      id: id ?? this.id,
      word: word ?? this.word,
    );
  }

  HistoryWordModel toModel() {
    return HistoryWordModel(
      word: word,
      id: id,
    );
  }

  factory HistoryWordEntity.empty() {
    return const HistoryWordEntity();
  }
}
