import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/blocs/popular/popular_bloc.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';

class MockPopularBloc extends MockBloc<PopularEvent, PopularState>
    implements PopularBloc {}

class MoviePopularEventFake extends Fake implements PopularEvent {}

class MoviePopularStateFake extends Fake implements PopularState {}

void main() {
  late MockPopularBloc mockPopularBloc;

  setUpAll(() {
    registerFallbackValue(MoviePopularEventFake());
    registerFallbackValue(MoviePopularStateFake());
    mockPopularBloc = MockPopularBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularBloc>(
      create: (_) => mockPopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() => {mockPopularBloc.close()});

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularBloc.state).thenReturn(PopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularBloc.state).thenReturn(PopularLoaded([]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularBloc.state).thenReturn(PopularError('Error'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
