import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/presentation/blocs/detail/detail_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/pages/pages.dart';

import '../../../dummy_data/dummy_objects.dart';

class MockDetailBloc extends MockBloc<DetailEvent, DetailState>
    implements DetailBloc {}

class MovieDetailEventFake extends Fake implements DetailEvent {}

class MovieDetailStateFake extends Fake implements DetailState {}

// @GenerateMocks([DetailBloc])
void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();

  late MockDetailBloc mockDetailBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieDetailStateFake());
    mockDetailBloc = MockDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    // return MultiProvider(providers: [
    //   BlocProvider(
    //       create: (_) => mockDetailBloc
    //         ..add(RequestDetail(1))
    //         ..add(LoadStatusWatchlist(1)))
    // ], child: MaterialApp(home: body));
    return BlocProvider<DetailBloc>.value(
      value: mockDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() => {mockDetailBloc.close()});

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailBloc.state).thenReturn(DetailState(
        movieDetail: testMovieDetail,
        isAddedToWatchlist: false,
        message: '',
        movieDetailState: RequestState.Loaded,
        movieRecommendations: [],
        movieRecommendationsState: RequestState.Loaded,
        watchlistMessage: ''));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockDetailBloc.state).thenReturn(DetailState(
        movieDetail: testMovieDetail,
        isAddedToWatchlist: true,
        message: '',
        movieDetailState: RequestState.Loaded,
        movieRecommendations: [],
        movieRecommendationsState: RequestState.Loaded,
        watchlistMessage: ''));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  // testWidgets(
  //     'Watchlist button should display Snackbar when added to watchlist',
  //     (WidgetTester tester) async {
  //   when(() => mockDetailBloc.state).thenReturn(DetailState(
  //       movieDetail: testMovieDetail,
  //       isAddedToWatchlist: false,
  //       message: '',
  //       movieDetailState: RequestState.Loaded,
  //       movieRecommendations: [],
  //       movieRecommendationsState: RequestState.Loaded,
  //       watchlistMessage: 'Added to Watchlist'));

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(SnackBar), findsOneWidget);
  //   expect(find.text('Added to Watchlist'), findsOneWidget);
  // });

  // testWidgets(
  //     'Watchlist button should display AlertDialog when add to watchlist failed',
  //     (WidgetTester tester) async {
  //   when(() => mockDetailBloc.state).thenReturn(DetailState(
  //       movieDetail: testMovieDetail,
  //       isAddedToWatchlist: false,
  //       message: '',
  //       movieDetailState: RequestState.Loaded,
  //       movieRecommendations: [],
  //       movieRecommendationsState: RequestState.Loaded,
  //       watchlistMessage: 'Failed'));

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(AlertDialog), findsOneWidget);
  //   expect(find.text('Failed'), findsOneWidget);
  // });
}
