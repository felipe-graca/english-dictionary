// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:english_dictionary/core/feature/words/data/models/gpt_request_model.dart';
import 'package:equatable/equatable.dart';

class GptRequestEntity extends Equatable {
  final String model;
  final List<GptRequestMessageEntity> messages;

  const GptRequestEntity({
    this.messages = const <GptRequestMessageEntity>[],
    this.model = 'gpt-3.5-turbo',
  });

  @override
  List<Object> get props => [messages];

  GptRequestModel toModel() {
    return GptRequestModel(
      messages: List<GptRequestMessageModel>.from(messages.map((e) => e.toModel())),
    );
  }

  GptRequestEntity copyWith({
    List<GptRequestMessageEntity>? messages,
    int? maxTokens,
  }) {
    return GptRequestEntity(
      messages: messages ?? this.messages,
    );
  }
}

class GptRequestMessageEntity extends Equatable {
  final String role;
  final String content;

  const GptRequestMessageEntity({this.role = '', this.content = ''});

  @override
  List<Object> get props => [role, content];

  GptRequestMessageEntity copyWith({
    String? role,
    String? content,
  }) {
    return GptRequestMessageEntity(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }

  GptRequestMessageModel toModel() {
    return GptRequestMessageModel(
      role: role,
      content: content,
    );
  }
}
