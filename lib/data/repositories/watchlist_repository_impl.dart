import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/data/datasources/watchlist_data_source.dart';
import 'package:ditonton/data/models/watchlist_table.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/repositories/watchlist_repositories.dart';
import 'package:movies/data/datasources/movie_local_data_source.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/domain/entities/tv_detail.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final MovieLocalDataSource localMovieDataSource;
  final TVLocalDataSource localTVDataSource;
  final WatchlistLocalDataSource localWatchlistDataSource;

  WatchlistRepositoryImpl({
    required this.localMovieDataSource,
    required this.localTVDataSource,
    required this.localWatchlistDataSource,
  });

  @override
  Future<Either<Failure, List<Watchlist>>> getWatchlist() async {
    final result = await localWatchlistDataSource.getWatchlist();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedMovieToWatchlist(int id) async {
    final result = await localMovieDataSource.getMovieById(id);
    return result != null;
  }

  @override
  Future<bool> isAddedTVToWatchlist(int id) async {
    final result = await localTVDataSource.getTVById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeMovieWatchlist(
      MovieDetail movie) async {
    try {
      final result = await localMovieDataSource
          .removeWatchlist(WatchListTable.fromMovieEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeTVWatchlist(TVDetail tv) async {
    try {
      final result = await localTVDataSource
          .removeWatchlist(WatchListTable.fromTVEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveMovieWatchlist(MovieDetail movie) async {
    try {
      final result = await localMovieDataSource
          .insertWatchlist(WatchListTable.fromMovieEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> saveTVWatchlist(TVDetail tv) async {
    try {
      final result = await localTVDataSource
          .insertWatchlist(WatchListTable.fromTVEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }
}
