import 'package:english_dictionary/core/feature/word_signification/data/datasource/get_word_signification/get_word_signification_datasource.dart';
import 'package:english_dictionary/core/feature/word_signification/data/repositories/get_word_signification/get_word_signification_repository.dart';
import 'package:english_dictionary/core/feature/word_signification/data/repositories/get_word_signification/get_word_signification_trpository_interface.dart';
import 'package:mockito/annotations.dart';

import 'get_word_signification_repository_teste.mocks.dart';

@GenerateMocks([GetWordSignificationDatasource])
main() {
  final datasource = MockGetWordSignificationDatasource();
  final IGetWordSignificationRepository repository = GetWordSignificationRepository(datasource);
}
