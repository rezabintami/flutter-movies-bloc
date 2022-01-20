import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTV])
void main() {
  late MockGetTopRatedTV mockGetTopRatedTV;
  late TopRatedTVNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTV = MockGetTopRatedTV();
    notifier = TopRatedTVNotifier(getTopRatedTV: mockGetTopRatedTV)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTV = TV(
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

  final tTVList = <TV>[tTV];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedTV.execute()).thenAnswer((_) async => Right(tTVList));
    // act
    notifier.fetchTopRatedTV();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedTV.execute()).thenAnswer((_) async => Right(tTVList));
    // act
    await notifier.fetchTopRatedTV();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tv, tTVList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTV.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTV();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
