import 'package:dio/dio.dart';
import 'package:english_dictionary/core/feature/word_signification/core/serivces/rapidapi/rapidapi_service.dart';
import 'package:english_dictionary/core/feature/word_signification/core/serivces/rapidapi/rapidapi_service_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'rapidapi_service_test.mocks.dart';

@GenerateMocks([Dio])
main() {
  final dio = MockDio();
  final IRapidapiService rapidapiService = RapidapiService(dio);

  group("buildAuthOptions()", () {
    test("should return an Options object with headers", () async {
      final options = await rapidapiService.buildAuthOptions();
      expect(options.headers, isNotNull);
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
        final response = await rapidapiService.get("https://www.google.com");

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
          final response = await rapidapiService.get("https://www.google.com");

          expect(response.statusCode, 200);
        },
      );
    });

    group('failure case', () {
      test(
        'Shold return a response with status code 400',
        () async {
          when(dio.get(any)).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 400,
              requestOptions: RequestOptions(path: ""),
            ),
          );
          final response = await rapidapiService.get("https://www.google.com");

          expect(response.statusCode, 400);
        },
      );

      test(
        'Shold return a response with status code 401',
        () async {
          when(dio.get(any)).thenAnswer(
            (_) async => Response(
              data: {},
              statusCode: 401,
              requestOptions: RequestOptions(path: ""),
            ),
          );
          final response = await rapidapiService.get("https://www.google.com");

          expect(response.statusCode, 401);
        },
      );
    });
  });
}
