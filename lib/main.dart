import 'package:core/core.dart';
import 'package:ditonton/presentation/blocs/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await HttpSSLPinning.init();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //! BLOC TV
        BlocProvider(create: (_) => di.locator<tv.SearchBloc>()),
        BlocProvider(create: (_) => di.locator<tv.DetailBloc>()),
        BlocProvider(create: (_) => di.locator<tv.NowPlayingBloc>()),
        BlocProvider(create: (_) => di.locator<tv.PopularBloc>()),
        BlocProvider(create: (_) => di.locator<tv.TopRatedBloc>()),

        //! BLOC MOVIE
        BlocProvider(create: (_) => di.locator<movies.SearchBloc>()),
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
              return MaterialPageRoute(builder: (_) => WatchlistPage());
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
