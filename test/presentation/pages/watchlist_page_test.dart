import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/blocs/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:ditonton/presentation/widgets/watchlist_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistBloc extends MockBloc<WatchlistEvent, WatchlistState>
    implements WatchlistBloc {}

class WatchlistStateFake extends Fake implements WatchlistState {}

class WatchlistEventFake extends Fake implements WatchlistEvent {}

void main() {
  late MockWatchlistBloc mockWatchlistBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistEventFake());
    registerFallbackValue(WatchlistStateFake());
    mockWatchlistBloc = MockWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistBloc>(
      create: (_) => mockWatchlistBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() => {mockWatchlistBloc.close()});

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockWatchlistBloc.state).thenReturn(WatchlistLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockWatchlistBloc.state)
        .thenReturn(WatchlistLoaded(testWatchlistList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

    expect(listViewFinder, findsOneWidget);
    expect(find.byType(WatchlistCard), findsWidgets);
    expect(find.byType(Padding), findsWidgets);
    expect(find.byType(Center), findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockWatchlistBloc.state).thenReturn(WatchlistError('Error'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

    expect(textFinder, findsOneWidget);
  });
}
