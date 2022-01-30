import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/presentation/blocs/search/search_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/pages/search_movie_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchMoviesEvent extends Fake implements SearchEvent {}

class MockSearchMoviesState extends Fake implements SearchState {}

class MockSearchMoviesBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

void main() {
  late MockSearchMoviesBloc mockSearchMoviesBloc;

  setUp(() {
    registerFallbackValue(MockSearchMoviesEvent());
    registerFallbackValue(MockSearchMoviesState());
    mockSearchMoviesBloc = MockSearchMoviesBloc();
  });

  tearDown(() => mockSearchMoviesBloc.close());

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchBloc>.value(
      value: mockSearchMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    "Page should display Loading indicator when data is loading",
    (WidgetTester tester) async {
      when(() => mockSearchMoviesBloc.state).thenReturn(SearchLoading());

      final progressbarFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(
        SearchMoviePage(),
      ));

      expect(progressbarFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display ListView when data is gotten successful",
    (WidgetTester tester) async {
      when(() => mockSearchMoviesBloc.state)
          .thenReturn(SearchHasData(testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(
        SearchMoviePage(),
      ));

      expect(listViewFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display error message when data failed to fetch",
    (WidgetTester tester) async {
      when(() => mockSearchMoviesBloc.state).thenReturn(SearchError('error'));

      final errorKeyFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(
        SearchMoviePage(),
      ));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(errorKeyFinder, findsOneWidget);
    },
  );

  testWidgets(
    "Page should display empty message when the searched data is empty",
    (WidgetTester tester) async {
      when(() => mockSearchMoviesBloc.state).thenReturn(SearchEmpty());

      final emptyKeyFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(
        SearchMoviePage(),
      ));

      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(seconds: 1));
      }

      expect(emptyKeyFinder, findsOneWidget);
    },
  );
}
