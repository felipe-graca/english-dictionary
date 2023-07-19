import 'package:english_dictionary/core/feature/words/core/errors/words_failure.dart';
import 'package:english_dictionary/core/feature/words/domain/entities/gpt_request_entity.dart';
import 'package:english_dictionary/core/usecase/usecase.dart';

abstract interface class IGetGptWordsUsecase implements UseCase<List<String>, GptRequestEntity> {
  @override
  Future<(GptFailure?, List<String>)> call(GptRequestEntity entity);
}
