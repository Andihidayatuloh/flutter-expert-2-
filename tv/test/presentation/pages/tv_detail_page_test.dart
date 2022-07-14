import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/dummy_objects.dart';

class TvDetailEventFake extends Fake implements TvDetailEvent {}

class TvDetailStateFake extends Fake implements TvDetailState {}

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements BlocTvDetailBloc {}

void main() {
  late MockTvDetailBloc mockTvDetailBloc;

  setUpAll(() {
    registerFallbackValue(TvDetailEventFake());
    registerFallbackValue(TvDetailStateFake());
  });

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<BlocTvDetailBloc>.value(
      value: mockTvDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state).thenReturn(
        TvDetailState.initial().copyWith(tvState: RequestState.Loading));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('should display loading when recommendationState loading',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(TvDetailState.initial().copyWith(
      tvState: RequestState.Loaded,
      tvDetail: testTvDetail,
      recommendationState: RequestState.Loading,
      tvRecommendations: <Tv>[],
      isAddedToWatchlist: false,
    ));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(progressBarFinder, findsWidgets);
  });

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state).thenReturn(
      TvDetailState.initial().copyWith(
        tvState: RequestState.Loaded,
        tvDetail: testTvDetail,
        recommendationState: RequestState.Loaded,
        tvRecommendations: [testTv],
        isAddedToWatchlist: false,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state).thenReturn(
      TvDetailState.initial().copyWith(
        tvState: RequestState.Loaded,
        tvDetail: testTvDetail,
        recommendationState: RequestState.Loaded,
        tvRecommendations: [testTv],
        isAddedToWatchlist: true,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    whenListen(
        mockTvDetailBloc,
        Stream.fromIterable([
          TvDetailState.initial().copyWith(
            tvState: RequestState.Loaded,
            tvDetail: testTvDetail,
            recommendationState: RequestState.Loaded,
            tvRecommendations: [testTv],
            isAddedToWatchlist: false,
          ),
          TvDetailState.initial().copyWith(
            tvState: RequestState.Loaded,
            tvDetail: testTvDetail,
            recommendationState: RequestState.Loaded,
            tvRecommendations: [testTv],
            isAddedToWatchlist: false,
            watchlistMessage: 'Added to Watchlist',
          ),
        ]),
        initialState: TvDetailState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    whenListen(
        mockTvDetailBloc,
        Stream.fromIterable([
          TvDetailState.initial().copyWith(
            tvState: RequestState.Loaded,
            tvDetail: testTvDetail,
            recommendationState: RequestState.Loaded,
            tvRecommendations: [testTv],
            isAddedToWatchlist: false,
          ),
          TvDetailState.initial().copyWith(
            tvState: RequestState.Loaded,
            tvDetail: testTvDetail,
            recommendationState: RequestState.Loaded,
            tvRecommendations: [testTv],
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed',
          ),
          TvDetailState.initial().copyWith(
            tvState: RequestState.Loaded,
            tvDetail: testTvDetail,
            recommendationState: RequestState.Loaded,
            tvRecommendations: [testTv],
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed ',
          ),
        ]),
        initialState: TvDetailState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
