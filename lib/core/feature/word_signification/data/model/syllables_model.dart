import 'dart:convert';

import 'package:english_dictionary/core/feature/word_signification/domain/entities/syllables_entity.dart';

class SyllablesModel extends SyllablesEntity {
  const SyllablesModel({
    int count = 0,
    List<String> list = const [],
  }) : super(count: count, list: list);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'list': list,
    };
  }

  factory SyllablesModel.fromMap(Map<String, dynamic> map) {
    return SyllablesModel(
      count: map['count'] ?? 0,
      list: List<String>.from(map['list'] ?? <dynamic>[]),
    );
  }

  SyllablesEntity toEntity() {
    return SyllablesEntity(
      count: count,
      list: list,
    );
  }

  factory SyllablesModel.fromJson(String source) => SyllablesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());
}
