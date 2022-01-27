import 'package:ditonton/data/models/watchlist_table.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:movies/data/models/movie_table.dart';
import 'package:movies/domain/entities/entities.dart' as movie;
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/domain/entities/entities.dart' as tv;

final testMovie = movie.Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testWatch = Watchlist(
  id: 557,
  isMovie: 1,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  title: 'Spider-Man',
);

final testMovieList = [testMovie];
final testWatchlistList = [testWatch];

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

final testWatchlistMovie = movie.Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlist = Watchlist.watchlist(
  id: 1,
  isMovie: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTVTable = TVTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchListTable = WatchListTable(
  id: 1,
  isMovie: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchListTVTable = WatchListTable(
  id: 1,
  isMovie: 0,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'isMovie': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTVMap = {
  'id': 1,
  'isMovie': 0,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};
