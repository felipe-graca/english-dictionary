import 'package:english_dictionary/core/feature/auth/core/errors/auth_failures.dart';
import 'package:english_dictionary/core/feature/auth/data/datasource/get_user_details/get_user_details_datasource.dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../model/user_data_model_test.dart';
import 'get_user_details_repository_test.mocks.dart';

@GenerateMocks([GetUserDetailsDatasource])
void main() {
  group(
    'Get user details repository',
    () {
      test(
        'should return user details',
        () async {
          final datasource = MockGetUserDetailsDatasource();
          when(datasource.getUserDetails()).thenAnswer((_) async => userDataModel);
          final result = await datasource.getUserDetails();
          expect(result, userDataModel);
        },
      );

      test(
        'should return null when not found user details',
        () async {
          final datasource = MockGetUserDetailsDatasource();
          when(datasource.getUserDetails()).thenThrow(GetUserDetailsFailure());
          expect(() => datasource.getUserDetails(), throwsA(isA<GetUserDetailsFailure>()));
        },
      );
    },
  );
}
