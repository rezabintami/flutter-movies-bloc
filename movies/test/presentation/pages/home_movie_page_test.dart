import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/movies.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockNowPlayingMoviesEvent extends Fake implements NowPlayingEvent {}

class MockNowPlayingMoviesState extends Fake implements NowPlayingState {}

class MockNowPlayingMoviesBloc
    extends MockBloc<NowPlayingEvent, NowPlayingState>
    implements NowPlayingBloc {}

class MockPopularMoviesEvent extends Fake implements PopularEvent {}

class MockPopularMoviesState extends Fake implements PopularState {}

class MockPopularMoviesBloc extends MockBloc<PopularEvent, PopularState>
    implements PopularBloc {}

class MockTopRatedMoviesEvent extends Fake implements TopRatedEvent {}

class MockTopRatedMoviesState extends Fake implements TopRatedState {}

class MockTopRatedMoviesBloc extends MockBloc<TopRatedEvent, TopRatedState>
    implements TopRatedBloc {}

void main() {
  late MockNowPlayingMoviesBloc mockGetNowPlayingMovies;
  late MockPopularMoviesBloc mockGetPopularMovies;
  late MockTopRatedMoviesBloc mockGetTopRatedMovies;

  setUp(() {
    registerFallbackValue(MockNowPlayingMoviesState());
    registerFallbackValue(MockNowPlayingMoviesEvent());
    mockGetNowPlayingMovies = MockNowPlayingMoviesBloc();

    registerFallbackValue(MockPopularMoviesEvent());
    registerFallbackValue(MockPopularMoviesState());
    mockGetPopularMovies = MockPopularMoviesBloc();

    registerFallbackValue(MockTopRatedMoviesEvent());
    registerFallbackValue(MockTopRatedMoviesState());
    mockGetTopRatedMovies = MockTopRatedMoviesBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    mockGetNowPlayingMovies.close();
    mockGetPopularMovies.close();
    mockGetTopRatedMovies.close();
  });
  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingBloc>(
          create: (context) => mockGetNowPlayingMovies,
        ),
        BlocProvider<PopularBloc>(
          create: (context) => mockGetPopularMovies,
        ),
        BlocProvider<TopRatedBloc>(
          create: (context) => mockGetTopRatedMovies,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(() => mockGetNowPlayingMovies.state).thenReturn(NowPlayingLoading());
    when(() => mockGetPopularMovies.state).thenReturn(PopularLoading());
    when(() => mockGetTopRatedMovies.state).thenReturn(TopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets(
      'Page should display listview of movies when HasData state occurred',
      (tester) async {
    when(() => mockGetNowPlayingMovies.state)
        .thenReturn(NowPlayingLoaded(testMovieList));
    when(() => mockGetPopularMovies.state)
        .thenReturn(PopularLoaded(testMovieList));
    when(() => mockGetTopRatedMovies.state)
        .thenReturn(TopRatedLoaded(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('Page should display error text when error', (tester) async {
    when(() => mockGetNowPlayingMovies.state)
        .thenReturn(NowPlayingError('error'));
    when(() => mockGetPopularMovies.state).thenReturn(PopularError('error'));
    when(() => mockGetTopRatedMovies.state).thenReturn(TopRatedError('error'));

    await tester.pumpWidget(_makeTestableWidget(HomeMoviePage()));

    expect(find.byKey(const Key('error_message')), findsNWidgets(3));
  });
}
