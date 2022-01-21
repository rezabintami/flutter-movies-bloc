import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:tv/domain/entities/tv_detail.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, String>> saveMovieWatchlist(MovieDetail movie);
  Future<Either<Failure, String>> removeMovieWatchlist(MovieDetail movie);
  Future<bool> isAddedMovieToWatchlist(int id);
  Future<Either<Failure, String>> saveTVWatchlist(TVDetail tv);
  Future<Either<Failure, String>> removeTVWatchlist(TVDetail tv);
  Future<bool> isAddedTVToWatchlist(int id);
  Future<Either<Failure, List<Watchlist>>> getWatchlist();
}
