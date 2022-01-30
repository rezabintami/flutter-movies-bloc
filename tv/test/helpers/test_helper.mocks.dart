// Mocks generated by Mockito 5.0.17 from annotations
// in tv/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:convert' as _i17;
import 'dart:typed_data' as _i18;

import 'package:core/core.dart' as _i7;
import 'package:dartz/dartz.dart' as _i2;
import 'package:ditonton/data/datasources/db/database_helper.dart' as _i15;
import 'package:ditonton/data/models/watchlist_table.dart' as _i13;
import 'package:http/http.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:sqflite/sqflite.dart' as _i16;
import 'package:tv/data/datasources/tv_local_data_source.dart' as _i12;
import 'package:tv/data/datasources/tv_remote_data_source.dart' as _i10;
import 'package:tv/data/models/tv_detail_model.dart' as _i3;
import 'package:tv/data/models/tv_model.dart' as _i11;
import 'package:tv/data/models/tv_table.dart' as _i14;
import 'package:tv/domain/entities/tv.dart' as _i8;
import 'package:tv/domain/entities/tv_detail.dart' as _i9;
import 'package:tv/domain/repositories/tv_repository.dart' as _i5;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

class _FakeTVDetailResponse_1 extends _i1.Fake implements _i3.TVDetailResponse {
}

class _FakeResponse_2 extends _i1.Fake implements _i4.Response {}

class _FakeStreamedResponse_3 extends _i1.Fake implements _i4.StreamedResponse {
}

/// A class which mocks [TVRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVRepository extends _i1.Mock implements _i5.TVRepository {
  MockTVRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TV>>> getNowPlayingTV() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingTV, []),
              returnValue: Future<_i2.Either<_i7.Failure, List<_i8.TV>>>.value(
                  _FakeEither_0<_i7.Failure, List<_i8.TV>>()))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TV>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TV>>> getPopularTV() =>
      (super.noSuchMethod(Invocation.method(#getPopularTV, []),
              returnValue: Future<_i2.Either<_i7.Failure, List<_i8.TV>>>.value(
                  _FakeEither_0<_i7.Failure, List<_i8.TV>>()))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TV>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TV>>> getTopRatedTV() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTV, []),
              returnValue: Future<_i2.Either<_i7.Failure, List<_i8.TV>>>.value(
                  _FakeEither_0<_i7.Failure, List<_i8.TV>>()))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TV>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, _i9.TVDetail>> getTVDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVDetail, [id]),
              returnValue: Future<_i2.Either<_i7.Failure, _i9.TVDetail>>.value(
                  _FakeEither_0<_i7.Failure, _i9.TVDetail>()))
          as _i6.Future<_i2.Either<_i7.Failure, _i9.TVDetail>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TV>>> getTVRecommendations(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVRecommendations, [id]),
              returnValue: Future<_i2.Either<_i7.Failure, List<_i8.TV>>>.value(
                  _FakeEither_0<_i7.Failure, List<_i8.TV>>()))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TV>>>);
  @override
  _i6.Future<_i2.Either<_i7.Failure, List<_i8.TV>>> searchTV(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTV, [query]),
              returnValue: Future<_i2.Either<_i7.Failure, List<_i8.TV>>>.value(
                  _FakeEither_0<_i7.Failure, List<_i8.TV>>()))
          as _i6.Future<_i2.Either<_i7.Failure, List<_i8.TV>>>);
}

/// A class which mocks [TVRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVRemoteDataSource extends _i1.Mock
    implements _i10.TVRemoteDataSource {
  MockTVRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<_i11.TVModel>> getNowPlayingTV() =>
      (super.noSuchMethod(Invocation.method(#getNowPlayingTV, []),
              returnValue: Future<List<_i11.TVModel>>.value(<_i11.TVModel>[]))
          as _i6.Future<List<_i11.TVModel>>);
  @override
  _i6.Future<List<_i11.TVModel>> getPopularTV() =>
      (super.noSuchMethod(Invocation.method(#getPopularTV, []),
              returnValue: Future<List<_i11.TVModel>>.value(<_i11.TVModel>[]))
          as _i6.Future<List<_i11.TVModel>>);
  @override
  _i6.Future<List<_i11.TVModel>> getTopRatedTV() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTV, []),
              returnValue: Future<List<_i11.TVModel>>.value(<_i11.TVModel>[]))
          as _i6.Future<List<_i11.TVModel>>);
  @override
  _i6.Future<_i3.TVDetailResponse> getTVDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVDetail, [id]),
              returnValue:
                  Future<_i3.TVDetailResponse>.value(_FakeTVDetailResponse_1()))
          as _i6.Future<_i3.TVDetailResponse>);
  @override
  _i6.Future<List<_i11.TVModel>> getTVRecommendations(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTVRecommendations, [id]),
              returnValue: Future<List<_i11.TVModel>>.value(<_i11.TVModel>[]))
          as _i6.Future<List<_i11.TVModel>>);
  @override
  _i6.Future<List<_i11.TVModel>> searchTV(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTV, [query]),
              returnValue: Future<List<_i11.TVModel>>.value(<_i11.TVModel>[]))
          as _i6.Future<List<_i11.TVModel>>);
}

/// A class which mocks [TVLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTVLocalDataSource extends _i1.Mock implements _i12.TVLocalDataSource {
  MockTVLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<String> insertWatchlist(_i13.WatchListTable? tv) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [tv]),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<String> removeWatchlist(_i13.WatchListTable? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tv]),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i14.TVTable?> getTVById(int? id) => (super.noSuchMethod(
      Invocation.method(#getTVById, [id]),
      returnValue: Future<_i14.TVTable?>.value()) as _i6.Future<_i14.TVTable?>);
}

/// A class which mocks [DatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseHelper extends _i1.Mock implements _i15.DatabaseHelper {
  MockDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i16.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i16.Database?>.value())
          as _i6.Future<_i16.Database?>);
  @override
  _i6.Future<int> insertWatchlist(_i13.WatchListTable? movie) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<int> removeWatchlist(_i13.WatchListTable? movie) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [movie]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<Map<String, dynamic>?> getMovieById(int? id, int? isMovie) =>
      (super.noSuchMethod(Invocation.method(#getMovieById, [id, isMovie]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i6.Future<Map<String, dynamic>?>);
  @override
  _i6.Future<List<Map<String, dynamic>>> getWatchlist() => (super.noSuchMethod(
      Invocation.method(#getWatchlist, []),
      returnValue: Future<List<Map<String, dynamic>>>.value(
          <Map<String, dynamic>>[])) as _i6.Future<List<Map<String, dynamic>>>);
  @override
  _i6.Future<int> insertWatchlistTV(_i13.WatchListTable? tv) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlistTV, [tv]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<int> removeWatchlistTV(_i13.WatchListTable? tv) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlistTV, [tv]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<Map<String, dynamic>?> getTVById(int? id, int? isMovie) =>
      (super.noSuchMethod(Invocation.method(#getTVById, [id, isMovie]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i6.Future<Map<String, dynamic>?>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i4.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i4.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i17.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i17.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i17.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<_i4.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i17.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i4.Response>.value(_FakeResponse_2()))
          as _i6.Future<_i4.Response>);
  @override
  _i6.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i6.Future<String>);
  @override
  _i6.Future<_i18.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i18.Uint8List>.value(_i18.Uint8List(0)))
          as _i6.Future<_i18.Uint8List>);
  @override
  _i6.Future<_i4.StreamedResponse> send(_i4.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i4.StreamedResponse>.value(_FakeStreamedResponse_3()))
          as _i6.Future<_i4.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}
