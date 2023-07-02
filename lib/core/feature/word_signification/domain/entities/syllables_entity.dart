// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:english_dictionary/core/feature/word_signification/data/model/syllables_model.dart';
import 'package:equatable/equatable.dart';

class SyllablesEntity extends Equatable {
  final String count;
  final List<String> list;

  const SyllablesEntity({
    this.count = '',
    this.list = const [],
  });

  @override
  List<Object?> get props => [count, list];

  SyllablesEntity copyWith({
    String? count,
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
}
