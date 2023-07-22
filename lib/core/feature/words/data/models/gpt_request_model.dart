import 'dart:convert';

import 'package:english_dictionary/core/feature/words/domain/entities/gpt_request_entity.dart';

class GptRequestModel extends GptRequestEntity {
  const GptRequestModel({
    String model = 'gpt-3.5-turbo',
    List<GptRequestMessageModel> messages = const <GptRequestMessageModel>[],
    int maxTokens = 120,
  }) : super(
          model: model,
          messages: messages,
        );

  Map<String, dynamic> toMap() {
    return {
      'model': model,
      'messages': messages.map((x) => x.toModel().toMap()).toList(),
    };
  }

  factory GptRequestModel.fromMap(Map<String, dynamic> map) {
    return GptRequestModel(
      model: map['model'],
      messages: List<GptRequestMessageModel>.from(map['messages']?.map((x) => GptRequestMessageModel.fromMap(x))),
    );
  }

  factory GptRequestModel.fromJson(String source) => GptRequestModel.fromMap(json.decode(source));
  String toJson() => json.encode(toMap());
}

class GptRequestMessageModel extends GptRequestMessageEntity {
  const GptRequestMessageModel({
    String role = '',
    String content = '',
  }) : super(
          role: role,
          content: content,
        );

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'content': content,
    };
  }

  factory GptRequestMessageModel.fromMap(Map<String, dynamic> map) {
    return GptRequestMessageModel(
      role: map['role'],
      content: map['content'],
    );
  }

  factory GptRequestMessageModel.fromJson(String source) => GptRequestMessageModel.fromMap(json.decode(source));
  String toJson() => json.encode(toMap());
}
