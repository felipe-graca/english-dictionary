// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'dictionary_cubit.dart';

class DictionaryState extends Equatable {
  final List<WordEntity> words;
  final bool loading;
  const DictionaryState({
    this.words = const <WordEntity>[],
    this.loading = false,
  });

  @override
  List<Object> get props => [
        words,
        loading,
      ];

  DictionaryState copyWith({
    List<WordEntity>? words,
    bool? loading,
  }) {
    return DictionaryState(
      words: words ?? this.words,
      loading: loading ?? this.loading,
    );
  }
}
