import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movies/domain/entities/watchlist.dart';
import 'package:movies/domain/repositories/movie_repository.dart';

class GetWatchlistMovies {
  final MovieRepository _repository;

  GetWatchlistMovies(this._repository);

  Future<Either<Failure, List<Watchlist>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
