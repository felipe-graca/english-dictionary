import 'dart:convert';

import 'package:english_dictionary/core/feature/words/domain/entities/words_request_entity.dart';

class WordsRequestModel extends WordsRequestEntity {
  const WordsRequestModel({
    String model = 'gpt-3.5-turbo',
    List<WordsRequestMessageModel> messages = const <WordsRequestMessageModel>[],
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

  factory WordsRequestModel.fromMap(Map<String, dynamic> map) {
    return WordsRequestModel(
      model: map['model'],
      messages: List<WordsRequestMessageModel>.from(map['messages']?.map((x) => WordsRequestMessageModel.fromMap(x))),
    );
  }

  factory WordsRequestModel.fromJson(String source) => WordsRequestModel.fromMap(json.decode(source));
  String toJson() => json.encode(toMap());
}

class WordsRequestMessageModel extends WordsRequestMessageEntity {
  const WordsRequestMessageModel({
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

  factory WordsRequestMessageModel.fromMap(Map<String, dynamic> map) {
    return WordsRequestMessageModel(
      role: map['role'],
      content: map['content'],
    );
  }

  factory WordsRequestMessageModel.fromJson(String source) => WordsRequestMessageModel.fromMap(json.decode(source));
  String toJson() => json.encode(toMap());
}
