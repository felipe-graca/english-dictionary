// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:english_dictionary/core/feature/word_signification/data/model/signification_request_model.dart';
import 'package:english_dictionary/core/services/gpt/gpt_service.dart';
import 'package:equatable/equatable.dart';

class SignificationRequestEntity extends Gpt with EquatableMixin {
  final List<SignificationRequestMessageEntity> messages;

  SignificationRequestEntity({
    this.messages = const <SignificationRequestMessageEntity>[],
  }) : super();

  @override
  List<Object> get props => [messages];

  SignificationRequestModel toModel() {
    return SignificationRequestModel(
      messages: List<SignificationRequestMessageModel>.from(messages.map((e) => e.toModel())),
    );
  }

  SignificationRequestEntity copyWith({
    List<SignificationRequestMessageEntity>? messages,
  }) {
    return SignificationRequestEntity(
      messages: messages ?? this.messages,
    );
  }
}

class SignificationRequestMessageEntity extends Equatable {
  final String role;
  final String content;

  const SignificationRequestMessageEntity({this.role = '', this.content = ''});

  @override
  List<Object> get props => [role, content];

  SignificationRequestMessageEntity copyWith({
    String? role,
    String? content,
  }) {
    return SignificationRequestMessageEntity(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }

  SignificationRequestMessageModel toModel() {
    return SignificationRequestMessageModel(
      role: role,
      content: content,
    );
  }
}
