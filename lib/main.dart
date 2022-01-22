import 'package:core/core.dart';
import 'package:ditonton/presentation/blocs/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_tv_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_tv_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:tv/tv.dart' as tv;
import 'package:movies/movies.dart' as movies;
import 'package:tv/tv.dart';

void main() async {
  // await Firebase.initializeApp();
  // await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTVNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTVNotifier>(),
        ),

        //! BLOC TV
        BlocProvider(
          create: (_) => di.locator<tv.SearchBloc>(),
        ),

        //! BLOC MOVIE
        BlocProvider(
          create: (_) => di.locator<movies.SearchBloc>(),
        ),
        BlocProvider(create: (_) => di.locator<movies.DetailBloc>()),
        BlocProvider(create: (_) => di.locator<movies.NowPlayingBloc>()),
        BlocProvider(create: (_) => di.locator<movies.PopularBloc>()),
        BlocProvider(create: (_) => di.locator<movies.TopRatedBloc>()),

        //! BLOC WATCHLIST
        BlocProvider(create: (_) => di.locator<WatchlistBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HOME_MOVIE_PAGE:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case POPULAR_MOVIE_PAGE:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TOP_RATED_MOVIE_PAGE:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case DETAIL_MOVIE_PAGE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case DETAIL_TV_PAGE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_MOVIE_PAGE:
              return CupertinoPageRoute(builder: (_) => SearchMoviePage());
            case SEARCH_TV_PAGE:
              return CupertinoPageRoute(builder: (_) => SearchTVPage());
            case HOME_TV_PAGE:
              return CupertinoPageRoute(builder: (_) => TVPage());
            case POPULAR_TV_PAGE:
              return CupertinoPageRoute(builder: (_) => PopularTVPage());
            case TOP_RATED_TV_PAGE:
              return CupertinoPageRoute(builder: (_) => TopRatedTVPage());
            case WATCHLIST_PAGE:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case ABOUT_PAGE:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
