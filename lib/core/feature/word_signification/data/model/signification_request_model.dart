import 'dart:convert';

import 'package:english_dictionary/core/feature/word_signification/domain/entities/signification_request_entity.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/words_request_entity.dart';

class SignificationRequestModel extends SignificationRequestEntity {
  SignificationRequestModel({
    List<SignificationRequestMessageModel> messages = const <SignificationRequestMessageModel>[],
  }) : super(messages: messages.map((e) => e.toEntity()).toList());

  Map<String, dynamic> toMap() {
    return {
      'model': super.model,
      'messages': messages.map((x) => x.toModel().toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}

class SignificationRequestMessageModel extends WordsRequestMessageEntity {
  const SignificationRequestMessageModel({
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

  factory SignificationRequestMessageModel.fromMap(Map<String, dynamic> map) {
    return SignificationRequestMessageModel(
      role: map['role'],
      content: map['content'],
    );
  }

  SignificationRequestMessageEntity toEntity() {
    return SignificationRequestMessageEntity(
      role: role,
      content: content,
    );
  }

  factory SignificationRequestMessageModel.fromJson(String source) => SignificationRequestMessageModel.fromMap(json.decode(source));
  String toJson() => json.encode(toMap());
}
