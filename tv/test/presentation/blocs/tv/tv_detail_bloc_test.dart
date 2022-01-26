import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/usecases.dart';
import 'package:tv/presentation/blocs/detail/detail_bloc.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTVDetail,
  GetTVRecommendations,
  GetTVWatchListStatus,
  SaveTVWatchlist,
  RemoveTVWatchlist,
])
void main() {
  late MockGetTVDetail mockGetTVDetail;
  late MockGetTVRecommendations mockGetTVRecommendations;
  late MockGetTVWatchListStatus mockGetWatchlistStatus;
  late MockSaveTVWatchlist mockSaveWatchlist;
  late MockRemoveTVWatchlist mockRemoveWatchlist;
  late DetailBloc tvDetailBloc;

  setUp(() {
    mockGetTVDetail = MockGetTVDetail();
    mockGetTVRecommendations = MockGetTVRecommendations();
    mockGetWatchlistStatus = MockGetTVWatchListStatus();
    mockSaveWatchlist = MockSaveTVWatchlist();
    mockRemoveWatchlist = MockRemoveTVWatchlist();
    tvDetailBloc = DetailBloc(
      getTVDetail: mockGetTVDetail,
      getTVRecommendations: mockGetTVRecommendations,
      getTVWatchListStatus: mockGetWatchlistStatus,
      saveTVWatchList: mockSaveWatchlist,
      removeTVWatchList: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  final tvDetailStateInit = DetailState.initial();

  test('initial state should be empty', () {
    expect(tvDetailBloc.state, tvDetailStateInit);
  });

  group('Get TV Detail and TV Recommendation', () {
    blocTest<DetailBloc, DetailState>(
      'Should emit [Loading, Loaded, Loaded] when tv-detail data and tv-recommendations are gotten successfully',
      build: () {
        when(mockGetTVDetail.execute(tId))
            .thenAnswer((_) async => Right(testTVDetail));
        when(mockGetTVRecommendations.execute(tId))
            .thenAnswer((_) async => Right(<TV>[]));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const RequestDetail(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvDetailStateInit.copyWith(
          tvDetailState: RequestState.Loading,
        ),
        tvDetailStateInit.copyWith(
          tvDetail: testTVDetail,
          tvDetailState: RequestState.Loaded,
          tvRecommendations: <TV>[],
          tvRecommendationsState: RequestState.Loading,
          message: '',
        ),
        tvDetailStateInit.copyWith(
          tvDetailState: RequestState.Loaded,
          tvRecommendationsState: RequestState.Loaded,
          tvRecommendations: <TV>[],
          message: '',
        )
      ],
      verify: (bloc) {
        verify(mockGetTVDetail.execute(tId));
        verify(mockGetTVRecommendations.execute(tId));
      },
    );

    blocTest<DetailBloc, DetailState>(
      'Should emit [Loading, Loaded, Error] when tv-detail data is gotten successfully and tv-recommendations are gotten unsuccessfully',
      build: () {
        when(mockGetTVDetail.execute(tId))
            .thenAnswer((_) async => Right(testTVDetail));
        when(mockGetTVRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const RequestDetail(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvDetailStateInit.copyWith(
          tvDetailState: RequestState.Loading,
        ),
        tvDetailStateInit.copyWith(
          tvDetail: testTVDetail,
          tvDetailState: RequestState.Loaded,
          tvRecommendations: <TV>[],
          tvRecommendationsState: RequestState.Loading,
          message: '',
        ),
        tvDetailStateInit.copyWith(
          tvDetailState: RequestState.Loaded,
          tvRecommendationsState: RequestState.Error,
          tvRecommendations: <TV>[],
          message: 'Failed',
        )
      ],
      verify: (bloc) {
        verify(mockGetTVDetail.execute(tId));
        verify(mockGetTVRecommendations.execute(tId));
      },
    );

    blocTest<DetailBloc, DetailState>(
      'Should emit [Loading, Error] when tv-detail data is gotten unsuccessfully',
      build: () {
        when(mockGetTVDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        when(mockGetTVRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const RequestDetail(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvDetailStateInit.copyWith(
          tvDetailState: RequestState.Loading,
        ),
        tvDetailStateInit.copyWith(
            tvDetailState: RequestState.Error, message: 'Failed'),
      ],
      verify: (bloc) {
        verify(mockGetTVDetail.execute(tId));
      },
    );
  });

  group('Watchlist', () {
    blocTest<DetailBloc, DetailState>(
      'should get the watchlist status',
      build: () {
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
        when(mockGetTVRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(LoadStatusWatchlist(tId)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvDetailStateInit.copyWith(
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
        when(mockSaveWatchlist.execute(testTVDetail))
            .thenAnswer((_) async => const Right('Saved'));
        when(mockGetWatchlistStatus.execute(testTVDetail.id))
            .thenAnswer((_) async => true);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(AddToWatchlist(testTVDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvDetailStateInit.copyWith(watchlistMessage: 'Saved'),
        tvDetailStateInit.copyWith(
          isAddedToWatchlist: true,
          watchlistMessage: 'Saved',
        ),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testTVDetail));
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<DetailBloc, DetailState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockRemoveWatchlist.execute(testTVDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchlistStatus.execute(testTVDetail.id))
            .thenAnswer((_) async => false);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveFromWatchlist(testTVDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvDetailStateInit.copyWith(watchlistMessage: 'Removed'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testTVDetail));
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<DetailBloc, DetailState>(
      'should update watchlist status when add watchlist success',
      build: () {
        when(mockSaveWatchlist.execute(testTVDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(testTVDetail.id))
            .thenAnswer((_) async => true);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(AddToWatchlist(testTVDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvDetailStateInit.copyWith(watchlistMessage: 'Added to Watchlist'),
        tvDetailStateInit.copyWith(
          isAddedToWatchlist: true,
          watchlistMessage: 'Added to Watchlist',
        ),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testTVDetail));
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<DetailBloc, DetailState>(
      'should update watchlist message when add watchlist failed',
      build: () {
        when(mockSaveWatchlist.execute(testTVDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchlistStatus.execute(testTVDetail.id))
            .thenAnswer((_) async => true);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(AddToWatchlist(testTVDetail)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        tvDetailStateInit.copyWith(watchlistMessage: 'Failed'),
        tvDetailStateInit.copyWith(
          isAddedToWatchlist: true,
          watchlistMessage: 'Failed',
        ),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testTVDetail));
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );
  });
}
