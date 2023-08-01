import 'package:flutter_test/flutter_test.dart';

import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:english_dictionary/core/feature/word_signification/core/services/rapidapi/rapidapi_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'rapidapi_service_test.mocks.dart';

// Create a mock of Dio for testing HttpService

@GenerateMocks([Dio])
void main() {
  group('RapidapiService', () {
    // Create a Dio mock and RapidapiService instance for each test
    late Dio dio;
    late RapidapiService rapidapiService;

    setUp(() {
      dio = MockDio();

      when(dio.interceptors).thenReturn(Interceptors()..add(PrettyDioLogger()));
      when(dio.options).thenReturn(BaseOptions()..headers.addAll({}));

      rapidapiService = RapidapiService(dio);
    });

    test('get should call super.get with proper parameters', () async {
      final response = Response(data: {'message': 'Hello'}, statusCode: 200, requestOptions: RequestOptions(path: ''));
      when(dio.get('https://www.example.com', options: anyNamed('options'))).thenAnswer((_) async => response);

      final result = await rapidapiService.get('https://www.example.com', options: Options());

      expect(result, response);

      verify(dio.get('https://www.example.com', options: anyNamed('options'))).called(1);
    });
  });
}
