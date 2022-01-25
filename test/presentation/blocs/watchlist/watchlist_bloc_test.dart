import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/usecases/get_watchlist.dart';
import 'package:ditonton/presentation/blocs/watchlist/watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlist])
void main() {
  late MockGetWatchlist mockGetWatchlist;
  late WatchlistBloc watchlistBloc;
  setUp(() {
    mockGetWatchlist = MockGetWatchlist();
    watchlistBloc = WatchlistBloc(mockGetWatchlist);
  });

  final tvWatchlist = Watchlist(
      id: 1,
      isMovie: 1,
      overview: 'overview',
      posterPath: 'posterPath',
      title: 'title');

  final tWatchlistList = <Watchlist>[tvWatchlist];

  test('initial state should be empty', () {
    expect(watchlistBloc.state, WatchlistInitial());
  });

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit [Loading, HasData] when watchlist data is gotten successfully',
    build: () {
      when(mockGetWatchlist.execute())
          .thenAnswer((_) async => Right(tWatchlistList));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(WatchlistFetch()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistLoading(),
      WatchlistLoaded(tWatchlistList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlist.execute());
    },
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit [Loading, Error] when get watchlist data is unsuccessful',
    build: () {
      when(mockGetWatchlist.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(WatchlistFetch()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WatchlistLoading(),
      WatchlistError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlist.execute());
    },
  );
}
