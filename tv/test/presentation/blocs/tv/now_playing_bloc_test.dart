import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/blocs/blocs.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';

import 'now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTV])
void main() {
  late MockGetNowPlayingTV mockGetNowPlayingTV;
  late NowPlayingBloc nowPlayingBloc;

  setUp(() {
    mockGetNowPlayingTV = MockGetNowPlayingTV();
    nowPlayingBloc = NowPlayingBloc(mockGetNowPlayingTV);
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

  test('initial state should be empty', () {
    expect(nowPlayingBloc.state, NowPlayingInitial());
  });

  blocTest<NowPlayingBloc, NowPlayingState>(
    'Should emit [Loading, HasData] when now-playing-tv data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTV.execute())
          .thenAnswer((_) async => Right(tTVList));
      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingFetch()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      NowPlayingLoading(),
      NowPlayingLoaded(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTV.execute());
    },
  );

  blocTest<NowPlayingBloc, NowPlayingState>(
    'Should emit [Loading, Error] when get now-playing-tv data is unsuccessful',
    build: () {
      when(mockGetNowPlayingTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingFetch()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      NowPlayingLoading(),
      NowPlayingError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTV.execute());
    },
  );
}
