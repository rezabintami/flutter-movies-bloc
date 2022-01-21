import 'package:ditonton/domain/repositories/watchlist_repositories.dart';

class GetMovieWatchListStatus {
  final WatchlistRepository repository;

  GetMovieWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedMovieToWatchlist(id);
  }
}
