import 'dart:convert';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/data/models/tv_detail_model.dart';
import 'package:tv/data/models/tv_response.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../env.dart';
import '../../json_reader.dart';

void main() {
  late TVRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TVRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing TV', () {
    final tTVList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/tv/tv_now_playing.json', '')))
        .tvList;

    test('should return list of TV Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('${Env.BASE_URL}/tv/airing_today?${Env.API_KEY}')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv/tv_now_playing.json', ''), 200));
      // act
      final result = await dataSource.getNowPlayingTV();
      // assert
      expect(result, equals(tTVList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('${Env.BASE_URL}/tv/airing_today?${Env.API_KEY}')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingTV();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TV', () {
    final tTVList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/tv/tv_popular.json', '')))
        .tvList;

    test('should return list of tv when response is success (200)', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('${Env.BASE_URL}/tv/popular?${Env.API_KEY}')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv/tv_popular.json', ''), 200));
      // act
      final result = await dataSource.getPopularTV();
      // assert
      expect(result, tTVList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('${Env.BASE_URL}/tv/popular?${Env.API_KEY}')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTV();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated TV', () {
    final tTVList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/tv/tv_top_rated.json', '')))
        .tvList;

    test('should return list of tv when response code is 200 ', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('${Env.BASE_URL}/tv/top_rated?${Env.API_KEY}')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv/tv_top_rated.json', ''), 200));
      // act
      final result = await dataSource.getTopRatedTV();
      // assert
      expect(result, tTVList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('${Env.BASE_URL}/tv/top_rated?${Env.API_KEY}')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTV();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    final tId = 1;
    final tTVDetail = TVDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv/tv_detail.json', '')));

    test('should return tv detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('${Env.BASE_URL}/tv/$tId?${Env.API_KEY}')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv/tv_detail.json', ''), 200));
      // act
      final result = await dataSource.getTVDetail(tId);
      print("hasil: $result");
      // assert
      expect(result, equals(tTVDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('${Env.BASE_URL}/tv/$tId?${Env.API_KEY}')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tTVList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/tv/tv_recommendations.json', '')))
        .tvList;
    final tId = 1;

    test('should return list of TV Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '${Env.BASE_URL}/tv/$tId/recommendations?${Env.API_KEY}')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv/tv_recommendations.json', ''), 200));
      // act
      final result = await dataSource.getTVRecommendations(tId);
      // assert
      expect(result, equals(tTVList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '${Env.BASE_URL}/tv/$tId/recommendations?${Env.API_KEY}')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTVRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv', () {
    final tSearchResult = TVResponse.fromJson(
            json.decode(readJson('dummy_data/tv/search_spiderman_tv.json', '')))
        .tvList;
    final tQuery = 'Spiderman';

    test('should return list of tv when response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '${Env.BASE_URL}/search/tv?${Env.API_KEY}&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv/search_spiderman_tv.json', ''), 200));
      // act
      final result = await dataSource.searchTV(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '${Env.BASE_URL}/search/tv?${Env.API_KEY}&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTV(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
