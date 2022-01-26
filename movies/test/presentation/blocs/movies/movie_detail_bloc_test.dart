import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_movie_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/save_movie_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/usecases.dart';
import 'package:movies/presentation/blocs/detail/detail_bloc.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetMovieWatchListStatus,
  SaveMovieWatchlist,
  RemoveMovieWatchlist,
])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetMovieWatchListStatus mockGetWatchlistStatus;
  late MockSaveMovieWatchlist mockSaveWatchlist;
  late MockRemoveMovieWatchlist mockRemoveWatchlist;
  late DetailBloc movieDetailBloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetMovieWatchListStatus();
    mockSaveWatchlist = MockSaveMovieWatchlist();
    mockRemoveWatchlist = MockRemoveMovieWatchlist();
    movieDetailBloc = DetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getMovieWatchListStatus: mockGetWatchlistStatus,
      saveMovieWatchlist: mockSaveWatchlist,
      removeMovieWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  final movieDetailStateInit = DetailState.initial();

  test('initial state should be empty', () {
    expect(movieDetailBloc.state, movieDetailStateInit);
  });

  group('Get Movie Detail and Movie Recommendation', () {
    blocTest<DetailBloc, DetailState>(
      'Should emit [Loading, Loaded, Loaded] when movie-detail data and movie-recommendations are gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(<Movie>[]));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const RequestDetail(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieDetailStateInit.copyWith(
          movieDetailState: RequestState.Loading,
        ),
        movieDetailStateInit.copyWith(
          movieDetail: testMovieDetail,
          movieDetailState: RequestState.Loaded,
          movieRecommendations: <Movie>[],
          movieRecommendationsState: RequestState.Loading,
          message: '',
        ),
        movieDetailStateInit.copyWith(
          movieDetailState: RequestState.Loaded,
          movieRecommendationsState: RequestState.Loaded,
          movieRecommendations: <Movie>[],
          message: '',
        )
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<DetailBloc, DetailState>(
      'Should emit [Loading, Loaded, Error] when movie-detail data is gotten successfully and movie-recommendations are gotten unsuccessfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const RequestDetail(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieDetailStateInit.copyWith(
          movieDetailState: RequestState.Loading,
        ),
        movieDetailStateInit.copyWith(
          movieDetail: testMovieDetail,
          movieDetailState: RequestState.Loaded,
          movieRecommendations: <Movie>[],
          movieRecommendationsState: RequestState.Loading,
          message: '',
        ),
        movieDetailStateInit.copyWith(
          movieDetailState: RequestState.Loaded,
          movieRecommendationsState: RequestState.Error,
          movieRecommendations: <Movie>[],
          message: 'Failed',
        )
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<DetailBloc, DetailState>(
      'Should emit [Loading, Error] when movie-detail data is gotten unsuccessfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const RequestDetail(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieDetailStateInit.copyWith(
          movieDetailState: RequestState.Loading,
        ),
        movieDetailStateInit.copyWith(
            movieDetailState: RequestState.Error, message: 'Failed'),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });

  group('Watchlist', () {
    blocTest<DetailBloc, DetailState>(
      'should get the watchlist status',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(LoadStatusWatchlist(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieDetailStateInit.copyWith(
          isAddedToWatchlist: true,
        ),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<DetailBloc, DetailState>(
      'should execute save watchlist when function called',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Saved'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(AddToWatchlist(testMovieDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieDetailStateInit.copyWith(watchlistMessage: 'Saved'),
        movieDetailStateInit.copyWith(
          isAddedToWatchlist: true,
          watchlistMessage: 'Saved',
        ),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<DetailBloc, DetailState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieDetailStateInit.copyWith(watchlistMessage: 'Removed'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<DetailBloc, DetailState>(
      'should update watchlist status when add watchlist success',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(AddToWatchlist(testMovieDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieDetailStateInit.copyWith(watchlistMessage: 'Added to Watchlist'),
        movieDetailStateInit.copyWith(
          isAddedToWatchlist: true,
          watchlistMessage: 'Added to Watchlist',
        ),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<DetailBloc, DetailState>(
      'should update watchlist message when add watchlist failed',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(AddToWatchlist(testMovieDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        movieDetailStateInit.copyWith(watchlistMessage: 'Failed'),
        movieDetailStateInit.copyWith(
          isAddedToWatchlist: true,
          watchlistMessage: 'Failed',
        ),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );
  });
}
