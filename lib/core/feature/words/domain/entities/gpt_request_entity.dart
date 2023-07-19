// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:english_dictionary/core/feature/words/data/models/gpt_request_model.dart';
import 'package:equatable/equatable.dart';

class GptRequestEntity extends Equatable {
  final String prompt;
  final int maxTokens;

  const GptRequestEntity({this.prompt = '', this.maxTokens = 250});

  @override
  List<Object> get props => [prompt, maxTokens];

  GptRequestModel toModel() {
    return GptRequestModel(
      prompt: prompt,
      maxTokens: maxTokens,
    );
  }

  GptRequestEntity copyWith({
    String? prompt,
    int? maxTokens,
  }) {
    return GptRequestEntity(
      prompt: prompt ?? this.prompt,
      maxTokens: maxTokens ?? this.maxTokens,
    );
  }
}
