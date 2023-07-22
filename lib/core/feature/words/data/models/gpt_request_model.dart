import 'dart:convert';

import 'package:english_dictionary/core/feature/words/domain/entities/gpt_request_entity.dart';

class GptRequestModel extends GptRequestEntity {
  const GptRequestModel({
    String prompt = '',
    int maxTokens = 120,
  }) : super(
          prompt: prompt,
          maxTokens: maxTokens,
        );

  Map<String, dynamic> toMap() {
    return {
      'prompt': prompt,
      'maxTokens': maxTokens,
    };
  }

  factory GptRequestModel.fromMap(Map<String, dynamic> map) {
    return GptRequestModel(
      prompt: map['prompt'],
      maxTokens: map['maxTokens'],
    );
  }

  factory GptRequestModel.fromJson(String source) => GptRequestModel.fromMap(json.decode(source));
  String toJson() => json.encode(toMap());
}
