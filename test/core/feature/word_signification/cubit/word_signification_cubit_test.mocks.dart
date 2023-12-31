// Mocks generated by Mockito 5.4.2 from annotations
// in english_dictionary/test/core/feature/word_signification/cubit/word_signification_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:english_dictionary/core/feature/word_signification/core/errors/word_signification_failure.dart'
    as _i5;
import 'package:english_dictionary/core/feature/word_signification/domain/entities/word_signification_entity.dart'
    as _i2;
import 'package:english_dictionary/core/feature/word_signification/domain/usecases/get_word_signification/get_word_signification_usecase.dart'
    as _i3;
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

class _FakeWordSignificationEntity_0 extends _i1.SmartFake
    implements _i2.WordSignificationEntity {
  _FakeWordSignificationEntity_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetWordSignificationUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWordSignificationUsecase extends _i1.Mock
    implements _i3.GetWordSignificationUsecase {
  MockGetWordSignificationUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<(_i5.GetWordSignificationFailure?, _i2.WordSignificationEntity)>
      call(String? params) => (super.noSuchMethod(
            Invocation.method(
              #call,
              [params],
            ),
            returnValue: _i4.Future<
                (
                  _i5.GetWordSignificationFailure?,
                  _i2.WordSignificationEntity
                )>.value((
              null,
              _FakeWordSignificationEntity_0(
                this,
                Invocation.method(
                  #call,
                  [params],
                ),
              )
            )),
          ) as _i4.Future<
              (_i5.GetWordSignificationFailure?, _i2.WordSignificationEntity)>);
}
