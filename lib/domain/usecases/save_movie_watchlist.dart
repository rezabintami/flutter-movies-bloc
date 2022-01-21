import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/repositories/watchlist_repositories.dart';
import 'package:movies/domain/entities/movie_detail.dart';

class SaveMovieWatchlist {
  final WatchlistRepository repository;

  SaveMovieWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail tv) {
    return repository.saveMovieWatchlist(tv);
  }
}
