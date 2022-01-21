import 'package:ditonton/data/models/watchlist_table.dart';
import 'db/database_helper.dart';

abstract class WatchlistLocalDataSource {
  Future<List<WatchListTable>> getWatchlist();
}

class WatchlistLocalDataSourceImpl implements WatchlistLocalDataSource {
  final DatabaseHelper databaseHelper;

  WatchlistLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<WatchListTable>> getWatchlist() async {
    final result = await databaseHelper.getWatchlist();
    return result.map((data) => WatchListTable.fromMap(data)).toList();
  }
}
