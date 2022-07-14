import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';

class TopRatedTvsEventFake extends Fake implements BlocTvEvent {}

class TopRatedTvsStateFake extends Fake implements BlocTvState {}

class MockTopRatedTvsBloc extends MockBloc<BlocTvEvent, BlocTvState>
    implements BlocTopTvBloc{}

void main() {
  late MockTopRatedTvsBloc mockTopRatedTvsBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedTvsEventFake());
    registerFallbackValue(TopRatedTvsStateFake());
  });

  setUp(() {
    mockTopRatedTvsBloc = MockTopRatedTvsBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<BlocTopTvBloc>.value(
      value: mockTopRatedTvsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvsBloc.state).thenReturn(TvLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvsBloc.state).thenReturn(TvLoaded([testTv]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvsBloc.state)
        .thenReturn(const TvError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
