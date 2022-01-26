import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
  });

  final testMovieTableId = testWatchListTable.id;
  final testTVTableId = testWatchListTVTable.id;

  group('Get Watchlist DB', () {
    test('should return list of movie map when getting watchlist movies',
        () async {
      // arrange
      when(mockDatabaseHelper.getWatchlist())
          .thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await mockDatabaseHelper.getWatchlist();
      // assert
      expect(result, [testMovieMap]);
    });
  });
  group('Movie test on db', () {
    test('should return movie id when inserting new movie', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testWatchListTable))
          .thenAnswer((_) async => testMovieTableId);
      // act
      final result =
          await mockDatabaseHelper.insertWatchlist(testWatchListTable);
      // assert
      expect(result, testMovieTableId);
    });

    test('should return movie id when deleting a movie', () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testWatchListTable))
          .thenAnswer((_) async => testMovieTableId);
      // act
      final result =
          await mockDatabaseHelper.removeWatchlist(testWatchListTable);
      // assert
      expect(result, testMovieTableId);
    });

    test('should return Movie Detail Table when getting movie by id is found',
        () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(testMovieTableId, 1))
          .thenAnswer((_) async => testMovieTable.toJson());
      // act
      final result = await mockDatabaseHelper.getMovieById(testMovieTableId, 1);
      // assert
      expect(result, testMovieTable.toJson());
    });

    test('should return null when getting movie by id is not found', () async {
      // arrange
      when(mockDatabaseHelper.getMovieById(testTVTableId, 0))
          .thenAnswer((_) async => null);
      // act
      final result = await mockDatabaseHelper.getMovieById(testTVTableId, 0);
      // assert
      expect(result, null);
    });
  });

  group('TV Show test on db', () {
    test('should return tv show id when inserting new tv show', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlist(testWatchListTVTable))
          .thenAnswer((_) async => testTVTableId);
      // act
      final result =
          await mockDatabaseHelper.insertWatchlist(testWatchListTVTable);
      // assert
      expect(result, testTVTableId);
    });

    test('should return tv show id when deleting a tv show', () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testWatchListTVTable))
          .thenAnswer((_) async => testTVTableId);
      // act
      final result =
          await mockDatabaseHelper.removeWatchlist(testWatchListTVTable);
      // assert
      expect(result, testTVTableId);
    });

    test(
        'should return TV Show Detail Table when getting tv show by id is found',
        () async {
      // arrange
      when(mockDatabaseHelper.getTVById(testTVTableId, 0))
          .thenAnswer((_) async => testWatchListTVTable.toJson());
      // act
      final result = await mockDatabaseHelper.getTVById(testTVTableId, 0);
      // assert
      expect(result, testWatchListTVTable.toJson());
    });

    test('should return null when getting tv show by id is not found',
        () async {
      // arrange
      when(mockDatabaseHelper.getTVById(testTVTableId, 0))
          .thenAnswer((_) async => null);
      // act
      final result = await mockDatabaseHelper.getTVById(testTVTableId, 0);
      // assert
      expect(result, null);
    });
  });
}
