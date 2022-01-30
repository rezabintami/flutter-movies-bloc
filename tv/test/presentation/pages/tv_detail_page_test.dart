import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/blocs/detail/detail_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockDetailBloc extends MockBloc<DetailEvent, DetailState>
    implements DetailBloc {}

class TVDetailEventFake extends Fake implements DetailEvent {}

class TVDetailStateFake extends Fake implements DetailState {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockDetailBloc mockDetailBloc;

  setUpAll(() {
    registerFallbackValue(TVDetailEventFake());
    registerFallbackValue(TVDetailStateFake());
    mockDetailBloc = MockDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<DetailBloc>.value(
      value: mockDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() => {mockDetailBloc.close()});

  testWidgets('Page should display progress bar when start to retrieve data',
      (WidgetTester tester) async {
    when(() => mockDetailBloc.state).thenReturn(DetailState(
        tvDetail: testTVDetail,
        isAddedToWatchlist: false,
        message: '',
        tvDetailState: RequestState.Loading,
        tvRecommendations: [],
        tvRecommendationsState: RequestState.Loading,
        watchlistMessage: ''));

    final progressbarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(
      id: 1,
    )));
    await tester.pump();

    expect(progressbarFinder, findsOneWidget);
  });

  testWidgets('All required widget should display',
      (WidgetTester tester) async {
    when(() => mockDetailBloc.state).thenReturn(DetailState(
        tvDetail: testTVDetail,
        isAddedToWatchlist: false,
        message: '',
        tvDetailState: RequestState.Loaded,
        tvRecommendations: [],
        tvRecommendationsState: RequestState.Loaded,
        watchlistMessage: ''));

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(
      id: 1,
    )));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailBloc.state).thenReturn(DetailState(
        tvDetail: testTVDetail,
        isAddedToWatchlist: false,
        message: '',
        tvDetailState: RequestState.Loaded,
        tvRecommendations: [],
        tvRecommendationsState: RequestState.Loaded,
        watchlistMessage: ''));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockDetailBloc.state).thenReturn(DetailState(
        tvDetail: testTVDetail,
        isAddedToWatchlist: true,
        message: '',
        tvDetailState: RequestState.Loaded,
        tvRecommendations: [],
        tvRecommendationsState: RequestState.Loaded,
        watchlistMessage: ''));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailBloc.state).thenReturn(DetailState(
        tvDetail: testTVDetail,
        isAddedToWatchlist: false,
        message: '',
        tvDetailState: RequestState.Loaded,
        tvRecommendations: [],
        tvRecommendationsState: RequestState.Loaded,
        watchlistMessage: 'Added to Watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(mockDetailBloc.state.watchlistMessage, 'Added to Watchlist');
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockDetailBloc.state).thenReturn(DetailState(
        tvDetail: testTVDetail,
        isAddedToWatchlist: false,
        message: '',
        tvDetailState: RequestState.Loaded,
        tvRecommendations: [],
        tvRecommendationsState: RequestState.Loaded,
        watchlistMessage: 'Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TVDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(mockDetailBloc.state.watchlistMessage, 'Failed');
  });
}
