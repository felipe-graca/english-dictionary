import 'package:english_dictionary/core/feature/auth/data/model/history_word_model.dart';
import 'package:equatable/equatable.dart';

class HistoryWordEntity extends Equatable {
  final String word;
  final String uid;

  const HistoryWordEntity({required this.word, required this.uid});

  @override
  List<Object?> get props => [
        word,
        uid,
      ];

  //copyWith
  HistoryWordEntity copyWith({
    final String? word,
    final String? uid,
  }) {
    return HistoryWordEntity(
      word: word ?? this.word,
      uid: uid ?? this.uid,
    );
  }

  HistoryWordModel toModel() {
    return HistoryWordModel(
      word: word,
      uid: uid,
    );
  }
}
