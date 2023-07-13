// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:english_dictionary/core/feature/word_signification/data/model/syllables_model.dart';
import 'package:equatable/equatable.dart';

class SyllablesEntity extends Equatable {
  final int count;
  final List<String> list;

  const SyllablesEntity({
    this.count = 0,
    this.list = const [],
  });

  @override
  List<Object?> get props => [count, list];

  SyllablesEntity copyWith({
    int? count,
    List<String>? list,
  }) {
    return SyllablesEntity(
      count: count ?? this.count,
      list: list ?? this.list,
    );
  }

  SyllablesModel toModel() {
    return SyllablesModel(
      count: count,
      list: list,
    );
  }

  bool get isEmpty => count == 0 && list.isEmpty;
}
