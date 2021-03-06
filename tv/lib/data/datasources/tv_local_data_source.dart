import 'package:core/core.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/watchlist_table.dart';
import 'package:tv/data/models/tv_table.dart';

abstract class TVLocalDataSource {
  Future<String> insertWatchlist(WatchListTable tv);
  Future<String> removeWatchlist(WatchListTable tv);
  Future<TVTable?> getTVById(int id);
}

class TVLocalDataSourceImpl implements TVLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchListTable tv) async {
    try {
      await databaseHelper.insertWatchlistTV(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchListTable tv) async {
    try {
      await databaseHelper.removeWatchlistTV(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TVTable?> getTVById(int id) async {
    final result = await databaseHelper.getTVById(id, 0);
    if (result != null) {
      return TVTable.fromMap(result);
    } else {
      return null;
    }
  }
}
