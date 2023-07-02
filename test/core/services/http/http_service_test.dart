import 'package:dio/dio.dart';
import 'package:english_dictionary/core/services/http/http_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'http_service_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final dio = MockDio();

  const token = String.fromEnvironment("WORD_SIGNIFICATION_API_KEY");
  final headers = {
    'X-RapidAPI-Key': token,
    'X-RapidAPI-Host': 'wordsapiv1.p.rapidapi.com',
  };

  when(dio.interceptors).thenReturn(Interceptors()..add(PrettyDioLogger()));
  when(dio.options).thenReturn(BaseOptions()..headers.addAll(headers));

  final httpService = HttpService(dio);

  group("buildAuthOptions()", () {
    test("should return an Options object with headers", () async {
      final options = await httpService.buildAuthOptions();
      expect(options.headers, headers);
    });
  });

  group("get()", () {
    group('success case', () {
      test("should return a response", () async {
        when(dio.get(any)).thenAnswer(
          (_) async => Response(
            data: {},
            statusCode: 200,
            requestOptions: RequestOptions(path: ""),
          ),
        );
        final response = await httpService.get("https://www.google.com");

        expect(response, isNotNull);
      });

      test(
        'Shold return a response with status code 200',
        () async {
          when(dio.get(any)).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 200,
              requestOptions: RequestOptions(path: ""),
            ),
          );
          final response = await httpService.get("https://www.google.com");

          expect(response.statusCode, 200);
        },
      );
    });
  });

  group('failure case', () {
    test('should return a response with status code 404', () async {
      when(dio.get(any)).thenAnswer(
        (_) async => Response(
          data: {},
          statusCode: 404,
          requestOptions: RequestOptions(path: ""),
        ),
      );
      final response = await httpService.get("https://www.google.com");

      expect(response.statusCode, 404);
    });

    test('should return a response with status code 500', () async {
      when(dio.get(any)).thenAnswer(
        (_) async => Response(
          data: {},
          statusCode: 500,
          requestOptions: RequestOptions(path: ""),
        ),
      );
      final response = await httpService.get("https://www.google.com");

      expect(response.statusCode, 500);
    });

    test('should return a response with status code 401', () async {
      when(dio.get(any)).thenAnswer(
        (_) async => Response(
          data: {},
          statusCode: 401,
          requestOptions: RequestOptions(path: ""),
        ),
      );
      final response = await httpService.get("https://www.google.com");

      expect(response.statusCode, 401);
    });
  });
}
