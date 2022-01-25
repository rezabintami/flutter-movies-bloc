import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/data/repositories/watchlist_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistRepositoryImpl repository;
  late MockMovieLocalDataSource mockmovielocalDataSource;
  late MockTVLocalDataSource mocktvLocalDataSource;
  late MockWatchlistLocalDataSource mockWatchlistLocalDataSource;
  setUp(() {
    mockmovielocalDataSource = MockMovieLocalDataSource();
    mocktvLocalDataSource = MockTVLocalDataSource();
    mockWatchlistLocalDataSource = MockWatchlistLocalDataSource();
    repository = WatchlistRepositoryImpl(
      localMovieDataSource: mockmovielocalDataSource,
      localTVDataSource: mocktvLocalDataSource,
      localWatchlistDataSource: mockWatchlistLocalDataSource,
    );
  });

  group('get Watchlist', () {
    test('should return list of watchlist', () async {
      // arrange
      when(mockWatchlistLocalDataSource.getWatchlist())
          .thenAnswer((_) async => [testWatchListTable]);
      // act
      final result = await repository.getWatchlist();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlist]);
    });
  });

  group('get status Movies', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockmovielocalDataSource.getMovieById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedMovieToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('remove Movies from Watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockmovielocalDataSource.removeWatchlist(testWatchListTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeMovieWatchlist(testMovieDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockmovielocalDataSource.removeWatchlist(testWatchListTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeMovieWatchlist(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('add Movies to Watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockmovielocalDataSource.insertWatchlist(testWatchListTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveMovieWatchlist(testMovieDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockmovielocalDataSource.insertWatchlist(testWatchListTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveMovieWatchlist(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('add TV to Watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mocktvLocalDataSource.insertWatchlist(testWatchListTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveTVWatchlist(testTVDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mocktvLocalDataSource.insertWatchlist(testWatchListTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveTVWatchlist(testTVDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove TV from Watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mocktvLocalDataSource.removeWatchlist(testWatchListTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeTVWatchlist(testTVDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mocktvLocalDataSource.removeWatchlist(testWatchListTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeTVWatchlist(testTVDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get status TV', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mocktvLocalDataSource.getTVById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedTVToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });
}
