import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/search_tv.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTV])
void main() {
  late TVSearchNotifier provider;
  late MockSearchTV mockSearchTV;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTV = MockSearchTV();
    provider = TVSearchNotifier(searchTV: mockSearchTV)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTVModel = TV(
    id: 1,
    name: 'name',
    originalName: 'originalName',
    voteCount: 3,
    overview: 'overview',
    posterPath: 'posterPath',
    backdropPath: 'backdropPath',
    voteAverage: 1.0,
    firstAirDate: 'firstAirDate',
    popularity: 1.0,
    genreIds: [1, 2, 3],
  );
  final tTVList = <TV>[tTVModel];
  final tQuery = 'spiderman';

  group('search tv', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      // act
      provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Right(tTVList));
      // act
      await provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tTVList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTV.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTVSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
