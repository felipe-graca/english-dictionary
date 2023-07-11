// Mocks generated by Mockito 5.4.2 from annotations
// in english_dictionary/test/core/feature/favorites/cubit/favorites_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i3;
import 'package:english_dictionary/core/feature/favorites/core/errors/favorites_failure.dart'
    as _i7;
import 'package:english_dictionary/core/feature/favorites/domain/entities/favorite_word_entity.dart'
    as _i8;
import 'package:english_dictionary/core/feature/favorites/domain/repositories/get_favorites_words/get_favorites_words_repository_interface.dart'
    as _i2;
import 'package:english_dictionary/core/feature/favorites/domain/repositories/remove_favorite_word/remove_favorite_word_repository_interface.dart'
    as _i4;
import 'package:english_dictionary/core/feature/favorites/domain/usecases/get_favorites_words/get_favorites_words_usecase.dart'
    as _i5;
import 'package:english_dictionary/core/feature/favorites/domain/usecases/remove_favorite_word/remove_favorite_word_usecase.dart'
    as _i10;
import 'package:english_dictionary/core/feature/favorites/domain/usecases/save_favorite_word/save_favorite_word_usecase.dart'
    as _i11;
import 'package:english_dictionary/core/usecase/usecase.dart' as _i9;
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

class _FakeIGetFavoritesWordsRepository_0 extends _i1.SmartFake
    implements _i2.IGetFavoritesWordsRepository {
  _FakeIGetFavoritesWordsRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIRemoveFavoriteWordRepository_2 extends _i1.SmartFake
    implements _i4.IRemoveFavoriteWordRepository {
  _FakeIRemoveFavoriteWordRepository_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetFavoritesWordsUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetFavoritesWordsUsecase extends _i1.Mock
    implements _i5.GetFavoritesWordsUsecase {
  MockGetFavoritesWordsUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IGetFavoritesWordsRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeIGetFavoritesWordsRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.IGetFavoritesWordsRepository);
  @override
  _i6.Future<
      _i3.Either<_i7.GetFavoritesWordsFailure,
          List<_i8.FavoriteWordEntity>>> call(_i9.NoParams? noParams) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [noParams],
        ),
        returnValue: _i6.Future<
            _i3.Either<_i7.GetFavoritesWordsFailure,
                List<_i8.FavoriteWordEntity>>>.value(_FakeEither_1<
            _i7.GetFavoritesWordsFailure, List<_i8.FavoriteWordEntity>>(
          this,
          Invocation.method(
            #call,
            [noParams],
          ),
        )),
      ) as _i6.Future<
          _i3.Either<_i7.GetFavoritesWordsFailure,
              List<_i8.FavoriteWordEntity>>>);
}

/// A class which mocks [RemoveFavoriteWordUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveFavoriteWordUsecase extends _i1.Mock
    implements _i10.RemoveFavoriteWordUsecase {
  MockRemoveFavoriteWordUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.IRemoveFavoriteWordRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeIRemoveFavoriteWordRepository_2(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i4.IRemoveFavoriteWordRepository);
  @override
  _i6.Future<_i3.Either<_i7.RemoveFavoriteWordFailure, bool>> call(
          _i8.FavoriteWordEntity? model) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [model],
        ),
        returnValue:
            _i6.Future<_i3.Either<_i7.RemoveFavoriteWordFailure, bool>>.value(
                _FakeEither_1<_i7.RemoveFavoriteWordFailure, bool>(
          this,
          Invocation.method(
            #call,
            [model],
          ),
        )),
      ) as _i6.Future<_i3.Either<_i7.RemoveFavoriteWordFailure, bool>>);
}

/// A class which mocks [SaveFavoriteWordUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveFavoriteWordUsecase extends _i1.Mock
    implements _i11.SaveFavoriteWordUsecase {
  MockSaveFavoriteWordUsecase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<
      _i3.Either<_i7.SaveFavoriteWordFailure, _i8.FavoriteWordEntity>> call(
          _i8.FavoriteWordEntity? model) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [model],
        ),
        returnValue: _i6.Future<
                _i3.Either<_i7.SaveFavoriteWordFailure,
                    _i8.FavoriteWordEntity>>.value(
            _FakeEither_1<_i7.SaveFavoriteWordFailure, _i8.FavoriteWordEntity>(
          this,
          Invocation.method(
            #call,
            [model],
          ),
        )),
      ) as _i6.Future<
          _i3.Either<_i7.SaveFavoriteWordFailure, _i8.FavoriteWordEntity>>);
}