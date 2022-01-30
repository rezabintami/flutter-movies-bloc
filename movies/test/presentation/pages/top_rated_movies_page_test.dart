import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/blocs/top_rated/top_rated_bloc.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';

class MockTopRatedBloc extends MockBloc<TopRatedEvent, TopRatedState>
    implements TopRatedBloc {}

class MovieTopRatedEventFake extends Fake implements TopRatedEvent {}

class MovieTopRatedStateFake extends Fake implements TopRatedState {}

void main() {
  late MockTopRatedBloc mockTopRatedBloc;

  setUpAll(() {
    registerFallbackValue(MovieTopRatedEventFake());
    registerFallbackValue(MovieTopRatedStateFake());
    mockTopRatedBloc = MockTopRatedBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedBloc>(
      create: (_) => mockTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedBloc.state).thenReturn(TopRatedLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedBloc.state).thenReturn(TopRatedLoaded([]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedBloc.state)
        .thenReturn(TopRatedError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
