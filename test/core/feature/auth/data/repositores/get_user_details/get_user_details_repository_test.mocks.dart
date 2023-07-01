// Mocks generated by Mockito 5.4.2 from annotations
// in english_dictionary/test/core/feature/auth/data/repositores/get_user_details/get_user_details_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:english_dictionary/core/feature/auth/data/datasource/get_user_details/get_user_details_datasource.dart.dart'
    as _i3;
import 'package:english_dictionary/core/feature/auth/data/model/user_data_model.dart'
    as _i2;
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

class _FakeUserDataModel_0 extends _i1.SmartFake implements _i2.UserDataModel {
  _FakeUserDataModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetUserDetailsDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetUserDetailsDatasource extends _i1.Mock
    implements _i3.GetUserDetailsDatasource {
  MockGetUserDetailsDatasource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.UserDataModel> getUserDetails() => (super.noSuchMethod(
        Invocation.method(
          #getUserDetails,
          [],
        ),
        returnValue: _i4.Future<_i2.UserDataModel>.value(_FakeUserDataModel_0(
          this,
          Invocation.method(
            #getUserDetails,
            [],
          ),
        )),
      ) as _i4.Future<_i2.UserDataModel>);
}
