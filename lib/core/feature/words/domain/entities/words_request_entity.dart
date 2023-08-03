// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:english_dictionary/core/feature/words/data/models/words_request_model.dart';
import 'package:equatable/equatable.dart';

class WordsRequestEntity extends Equatable {
  final String model;
  final List<WordsRequestMessageEntity> messages;

  const WordsRequestEntity({
    this.messages = const <WordsRequestMessageEntity>[],
    this.model = 'gpt-3.5-turbo',
  });

  @override
  List<Object> get props => [messages];

  WordsRequestModel toModel() {
    return WordsRequestModel(
      messages: List<WordsRequestMessageModel>.from(messages.map((e) => e.toModel())),
    );
  }

  WordsRequestEntity copyWith({
    List<WordsRequestMessageEntity>? messages,
  }) {
    return WordsRequestEntity(
      messages: messages ?? this.messages,
    );
  }
}

class WordsRequestMessageEntity extends Equatable {
  final String role;
  final String content;

  const WordsRequestMessageEntity({this.role = '', this.content = ''});

  @override
  List<Object> get props => [role, content];

  WordsRequestMessageEntity copyWith({
    String? role,
    String? content,
  }) {
    return WordsRequestMessageEntity(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }

  WordsRequestMessageModel toModel() {
    return WordsRequestMessageModel(
      role: role,
      content: content,
    );
  }
}
