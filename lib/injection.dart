import 'package:ditonton/data/datasources/watchlist_data_source.dart';
import 'package:ditonton/data/repositories/watchlist_repository_impl.dart';
import 'package:ditonton/domain/repositories/watchlist_repositories.dart';
import 'package:ditonton/domain/usecases/get_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/save_movie_watchlist.dart';
import 'package:ditonton/presentation/blocs/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/provider/popular_tv_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_notifier.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:movies/movies.dart' as movies;
import 'package:tv/tv.dart' as tv;

import 'data/datasources/db/database_helper.dart';
import 'domain/usecases/get_movie_watchlist_status.dart';
import 'domain/usecases/get_tv_watchlist_status.dart';
import 'domain/usecases/remove_tv_watchlist.dart';
import 'domain/usecases/save_tv_watchlist.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => PopularTVNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTVNotifier(
      getTopRatedTV: locator(),
    ),
  );

  locator.registerFactory(
    () => TVListNotifier(
      getNowPlayingTV: locator(),
      getPopularTV: locator(),
      getTopRatedTV: locator(),
    ),
  );
  locator.registerFactory(
    () => TVDetailNotifier(
      getTVDetail: locator(),
      getTVRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );

  // tv blocs
  locator.registerFactory(() => tv.SearchBloc(locator()));

  // movie blocs
  locator.registerFactory(() => movies.SearchBloc(locator()));
  locator.registerFactory(() => movies.DetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getMovieWatchListStatus: locator(),
      saveMovieWatchlist: locator(),
      removeMovieWatchlist: locator()));
  locator.registerFactory(() => movies.NowPlayingBloc(locator()));
  locator.registerFactory(() => movies.TopRatedBloc(locator()));
  locator.registerFactory(() => movies.PopularBloc(locator()));

  // watchlist blocs
  locator.registerFactory(() => WatchlistBloc(locator()));

  // use case
  locator.registerLazySingleton(() => movies.GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => movies.GetPopularMovies(locator()));
  locator.registerLazySingleton(() => movies.GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => movies.GetMovieDetail(locator()));
  locator
      .registerLazySingleton(() => movies.GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => movies.SearchMovies(locator()));

  locator.registerLazySingleton(() => tv.GetNowPlayingTV(locator()));
  locator.registerLazySingleton(() => tv.GetPopularTV(locator()));
  locator.registerLazySingleton(() => tv.GetTopRatedTV(locator()));
  locator.registerLazySingleton(() => tv.GetTVDetail(locator()));
  locator.registerLazySingleton(() => tv.GetTVRecommendations(locator()));
  locator.registerLazySingleton(() => tv.SearchTV(locator()));

  locator.registerLazySingleton(() => GetMovieWatchListStatus(locator()));
  locator.registerLazySingleton(() => GetTVWatchListStatus(locator()));
  locator.registerLazySingleton(() => GetWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTVWatchlist(locator()));
  locator.registerLazySingleton(() => SaveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => SaveTVWatchlist(locator()));

  // repository
  locator.registerLazySingleton<movies.MovieRepository>(
    () => movies.MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<tv.TVRepository>(
    () => tv.TVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<WatchlistRepository>(
    () => WatchlistRepositoryImpl(
        localMovieDataSource: locator(),
        localTVDataSource: locator(),
        localWatchlistDataSource: locator()),
  );

  // data sources
  locator.registerLazySingleton<movies.MovieRemoteDataSource>(
      () => movies.MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<movies.MovieLocalDataSource>(
      () => movies.MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<tv.TVRemoteDataSource>(
      () => tv.TVRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<tv.TVLocalDataSource>(
      () => tv.TVLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<WatchlistLocalDataSource>(
      () => WatchlistLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
