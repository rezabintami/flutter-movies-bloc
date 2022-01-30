import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/blocs/now_playing/now_playing_bloc.dart';
import 'package:tv/presentation/blocs/popular/popular_bloc.dart';
import 'package:tv/presentation/blocs/top_rated/top_rated_bloc.dart';
import 'package:tv/presentation/pages/tv_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockNowPlayingTVEvent extends Fake implements NowPlayingEvent {}

class MockNowPlayingTVState extends Fake implements NowPlayingState {}

class MockNowPlayingTVBloc extends MockBloc<NowPlayingEvent, NowPlayingState>
    implements NowPlayingBloc {}

class MockPopularTVEvent extends Fake implements PopularEvent {}

class MockPopularTVState extends Fake implements PopularState {}

class MockPopularTVBloc extends MockBloc<PopularEvent, PopularState>
    implements PopularBloc {}

class MockTopRatedTVEvent extends Fake implements TopRatedEvent {}

class MockTopRatedTVState extends Fake implements TopRatedState {}

class MockTopRatedTVBloc extends MockBloc<TopRatedEvent, TopRatedState>
    implements TopRatedBloc {}

void main() {
  late MockNowPlayingTVBloc mockGetNowPlayingTV;
  late MockPopularTVBloc mockGetPopularTV;
  late MockTopRatedTVBloc mockGetTopRatedTV;

  setUp(() {
    registerFallbackValue(MockNowPlayingTVState());
    registerFallbackValue(MockNowPlayingTVEvent());
    mockGetNowPlayingTV = MockNowPlayingTVBloc();

    registerFallbackValue(MockPopularTVEvent());
    registerFallbackValue(MockPopularTVState());
    mockGetPopularTV = MockPopularTVBloc();

    registerFallbackValue(MockTopRatedTVEvent());
    registerFallbackValue(MockTopRatedTVState());
    mockGetTopRatedTV = MockTopRatedTVBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    mockGetNowPlayingTV.close();
    mockGetPopularTV.close();
    mockGetTopRatedTV.close();
  });
  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingBloc>(
          create: (context) => mockGetNowPlayingTV,
        ),
        BlocProvider<PopularBloc>(
          create: (context) => mockGetPopularTV,
        ),
        BlocProvider<TopRatedBloc>(
          create: (context) => mockGetTopRatedTV,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(() => mockGetNowPlayingTV.state).thenReturn(NowPlayingLoading());
    when(() => mockGetPopularTV.state).thenReturn(PopularLoading());
    when(() => mockGetTopRatedTV.state).thenReturn(TopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TVPage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets('Page should display listview of tv when HasData state occurred',
      (tester) async {
    when(() => mockGetNowPlayingTV.state)
        .thenReturn(NowPlayingLoaded(testTVList));
    when(() => mockGetPopularTV.state).thenReturn(PopularLoaded(testTVList));
    when(() => mockGetTopRatedTV.state).thenReturn(TopRatedLoaded(testTVList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TVPage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('Page should display error text when error', (tester) async {
    when(() => mockGetNowPlayingTV.state).thenReturn(NowPlayingError('error'));
    when(() => mockGetPopularTV.state).thenReturn(PopularError('error'));
    when(() => mockGetTopRatedTV.state).thenReturn(TopRatedError('error'));

    await tester.pumpWidget(_makeTestableWidget(TVPage()));

    expect(find.byKey(const Key('error_message')), findsNWidgets(3));
  });
}
