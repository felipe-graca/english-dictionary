import 'package:english_dictionary/core/feature/favorites/data/models/favorites_word_model.dart';
import 'package:equatable/equatable.dart';

class FavoriteWordEntity extends Equatable {
  final String word;
  final String id;

  const FavoriteWordEntity({this.word = '', this.id = ''});

  @override
  List<Object?> get props => [
        word,
        id,
      ];

  //copyWith
  FavoriteWordEntity copyWith({
    final String? word,
    final String? id,
  }) {
    return FavoriteWordEntity(
      word: word ?? this.word,
      id: id ?? this.id,
    );
  }

  FavoriteWordModel toModel() {
    return FavoriteWordModel(
      word: word,
      id: id,
    );
  }
}
