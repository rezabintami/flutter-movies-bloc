import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/repositories/watchlist_repositories.dart';
import 'package:tv/domain/entities/tv_detail.dart';

class RemoveTVWatchlist {
  final WatchlistRepository repository;

  RemoveTVWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TVDetail tv) {
    return repository.removeTVWatchlist(tv);
  }
}
