// Mocks generated by Mockito 5.4.2 from annotations
// in english_dictionary/test/core/feature/user_details/domain/usecases/save_user/save_user_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:english_dictionary/core/feature/user_details/core/errors/user_details_failure.dart'
    as _i4;
import 'package:english_dictionary/core/feature/user_details/data/repositories/save_user/save_user_repository.dart'
    as _i2;
import 'package:english_dictionary/core/feature/user_details/domain/entities/user_details_entity.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [SaveUserRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveUserRepository extends _i1.Mock
    implements _i2.SaveUserRepository {
  MockSaveUserRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<(_i4.SaveUserFailure?, bool)> saveUser(
          _i5.UserDetailsEntity? userDataEntity) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveUser,
          [userDataEntity],
        ),
        returnValue:
            _i3.Future<(_i4.SaveUserFailure?, bool)>.value((null, false)),
      ) as _i3.Future<(_i4.SaveUserFailure?, bool)>);
}
