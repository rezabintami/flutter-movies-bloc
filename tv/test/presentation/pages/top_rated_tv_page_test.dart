import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/blocs/top_rated/top_rated_bloc.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';

class MockTopRatedBloc extends MockBloc<TopRatedEvent, TopRatedState>
    implements TopRatedBloc {}

class TVTopRatedEventFake extends Fake implements TopRatedEvent {}

class TVTopRatedStateFake extends Fake implements TopRatedState {}

void main() {
  late MockTopRatedBloc mockTopRatedBloc;

  setUpAll(() {
    registerFallbackValue(TVTopRatedEventFake());
    registerFallbackValue(TVTopRatedStateFake());
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

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedBloc.state).thenReturn(TopRatedLoaded([]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedBloc.state)
        .thenReturn(TopRatedError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTVPage()));

    expect(textFinder, findsOneWidget);
  });
}
