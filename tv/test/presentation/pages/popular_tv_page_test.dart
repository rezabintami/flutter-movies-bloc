import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/blocs/popular/popular_bloc.dart';
import 'package:tv/tv.dart';

class MockPopularBloc extends MockBloc<PopularEvent, PopularState>
    implements PopularBloc {}

class TVPopularEventFake extends Fake implements PopularEvent {}

class TVPopularStateFake extends Fake implements PopularState {}

void main() {
  late MockPopularBloc mockPopularBloc;

  setUpAll(() {
    registerFallbackValue(TVPopularEventFake());
    registerFallbackValue(TVPopularStateFake());
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

    await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularBloc.state).thenReturn(PopularLoaded([]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularBloc.state).thenReturn(PopularError('Error'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTVPage()));

    expect(textFinder, findsOneWidget);
  });
}
