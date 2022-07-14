import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';

class PopularTvsEventFake extends Fake implements BlocTvEvent {}

class PopularTvsStateFake extends Fake implements BlocTvState {}

class MockPopularTvBloc extends MockBloc<BlocTvEvent, BlocTvState>
    implements BlocPopularTvBloc {}

void main() {
  late MockPopularTvBloc mockPopularTvBloc;

  setUpAll(() {
    registerFallbackValue(PopularTvsEventFake());
    registerFallbackValue(PopularTvsStateFake());
  });

  setUp(() {
    mockPopularTvBloc = MockPopularTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<BlocPopularTvBloc>.value(
      value: mockPopularTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.state).thenReturn(TvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget( PopularTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.state).thenReturn(TvLoaded([testTv]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget( PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.state)
        .thenReturn(const TvError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget( PopularTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
