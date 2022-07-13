import 'package:movies/movies.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dumy_data/dummy_objects.dart';

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MovieDetailStateFake extends Fake implements BlocMovieDetailState {}

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, BlocMovieDetailState>
    implements BlocMovieDetailBloc {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieDetailStateFake());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<BlocMovieDetailBloc>.value(
      value: mockMovieDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(
        BlocMovieDetailState.initial()
            .copyWith(movieState: RequestState.Loading));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('should display loading when recommendationState loading',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(BlocMovieDetailState.initial().copyWith(
      movieState: RequestState.Loaded,
      movieDetail: testMovieDetail,
      recommendationState: RequestState.Loading,
      movieRecommendations: <Movie>[],
      isAddedToWatchlist: false,
    ));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(progressBarFinder, findsWidgets);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(
      BlocMovieDetailState.initial().copyWith(
        movieState: RequestState.Loaded,
        movieDetail: testMovieDetail,
        recommendationState: RequestState.Loaded,
        movieRecommendations: [testMovie],
        isAddedToWatchlist: false,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state).thenReturn(
      BlocMovieDetailState.initial().copyWith(
        movieState: RequestState.Loaded,
        movieDetail: testMovieDetail,
        recommendationState: RequestState.Loaded,
        movieRecommendations: [testMovie],
        isAddedToWatchlist: true,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    whenListen(
        mockMovieDetailBloc,
        Stream.fromIterable([
          BlocMovieDetailState.initial().copyWith(
            movieState: RequestState.Loaded,
            movieDetail: testMovieDetail,
            recommendationState: RequestState.Loaded,
            movieRecommendations: [testMovie],
            isAddedToWatchlist: false,
          ),
          BlocMovieDetailState.initial().copyWith(
            movieState: RequestState.Loaded,
            movieDetail: testMovieDetail,
            recommendationState: RequestState.Loaded,
            movieRecommendations: [testMovie],
            isAddedToWatchlist: false,
            watchlistMessage: 'Added to Watchlist',
          ),
        ]),
        initialState: BlocMovieDetailState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));
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
        mockMovieDetailBloc,
        Stream.fromIterable([
          BlocMovieDetailState.initial().copyWith(
            movieState: RequestState.Loaded,
            movieDetail: testMovieDetail,
            recommendationState: RequestState.Loaded,
            movieRecommendations: [testMovie],
            isAddedToWatchlist: false,
          ),
          BlocMovieDetailState.initial().copyWith(
            movieState: RequestState.Loaded,
            movieDetail: testMovieDetail,
            recommendationState: RequestState.Loaded,
            movieRecommendations: [testMovie],
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed',
          ),
          BlocMovieDetailState.initial().copyWith(
            movieState: RequestState.Loaded,
            movieDetail: testMovieDetail,
            recommendationState: RequestState.Loaded,
            movieRecommendations: [testMovie],
            isAddedToWatchlist: false,
            watchlistMessage: 'Failed ',
          ),
        ]),
        initialState: BlocMovieDetailState.initial());

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));
    await tester.pump();

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
