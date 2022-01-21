import 'package:ditonton/domain/repositories/watchlist_repositories.dart';

class GetTVWatchListStatus {
  final WatchlistRepository repository;

  GetTVWatchListStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedTVToWatchlist(id);
  }
}
