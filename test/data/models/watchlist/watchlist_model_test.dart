import 'package:ditonton/data/models/watchlist_table.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tv/domain/entities/entities.dart' as tv;
import 'package:movies/domain/entities/entities.dart' as movie;

import '../../../dummy_data/dummy_objects.dart';

void main() {
  final testWatchlistTable = WatchListTable(
    id: 557,
    isMovie: 1,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    title: 'Spider-Man',
  );

  final testWatchlist = Watchlist(
    id: 557,
    isMovie: 1,
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    title: 'Spider-Man',
  );

  final testMovieDetail = movie.MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [movie.Genre(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  final testMovieWatchlist = WatchListTable(
    id: 1,
    title: 'title',
    overview: 'overview',
    isMovie: 1,
    posterPath: 'posterPath',
  );

  final testTVDetail = tv.TVDetail(
      adult: false,
      backdropPath: 'backdropPath',
      genres: [tv.Genre(id: 1, name: 'Action')],
      id: 1,
      originalName: 'originalTitle',
      overview: 'overview',
      posterPath: 'posterPath',
      name: 'title',
      voteAverage: 1,
      voteCount: 1,
      homepage: 'homepage',
      inProduction: true,
      lastEpisode: null,
      nextEpisode: null,
      season: []);

  final testTVWatchlist = WatchListTable(
    id: 1,
    title: 'title',
    overview: 'overview',
    isMovie: 0,
    posterPath: 'posterPath',
  );

  test('should be a subclass of Watchlist entity', () async {
    final result = testWatchlistTable.toEntity();
    expect(result, testWatchlist);
  });

  test('should be convert TV Detail to WatchlistTable', () async {
    final result = WatchListTable.fromTVEntity(testTVDetail);
    expect(result, testTVWatchlist);
  });

  test('should be convert Movies Detail to WatchlistTable', () async {
    final result = WatchListTable.fromMovieEntity(testMovieDetail);
    expect(result, testMovieWatchlist);
  });

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = {
        'id': 1,
        'isMovie': 1,
        'overview': 'overview',
        'title': 'title',
        'posterPath': 'posterPath',
      };
      // act
      final result = WatchListTable.fromMap(jsonMap);
      // assert
      expect(result, testWatchListTable);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = testWatchListTable.toJson();
      // assert
      final expectedJsonMap = {
        'id': 1,
        'is_movie': 1,
        'overview': 'overview',
        'title': 'title',
        'posterPath': 'posterPath',
      };
      expect(result, expectedJsonMap);
    });
  });
}
