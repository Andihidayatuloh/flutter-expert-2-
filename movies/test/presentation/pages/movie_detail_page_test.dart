import 'package:core/core.dart';
import 'package:movies/movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../data_dummy/dummy_objects.dart';

void main() {
  late MockDetailMovieBloc mocksDetail;
  late MockWatchlistMovieStatus mocksStatus;
  late MockWatchlistMoviesAR mocksAR;

  setUpAll(() {
    registerFallbackValue(WatchlistMovieStatusStateFake());
    registerFallbackValue(WatchlistMovieStatusEventFake());
    registerFallbackValue(WatchlistMovieAREventFake());
    registerFallbackValue(WatchlistMovieARStateFake());
    registerFallbackValue(MovieDetailStateFake());
    registerFallbackValue(MovieDetailEventFake());
  });

  setUp(() {
    mocksStatus = MockWatchlistMovieStatus();
    mocksAR = MockWatchlistMoviesAR();
    mocksDetail = MockDetailMovieBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocMovieWatchlistStatus>.value(
          value: mocksStatus,
        ),
        BlocProvider<BlocWatchlistMovieAR>.value(
          value: mocksAR,
        ),
        BlocProvider<BlocMovieDetailBloc>.value(
          value: mocksDetail,
        ),
      ],
      child: MaterialApp(
        home: body,
        theme: ThemeData.dark().copyWith(
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          colorScheme: kColorScheme.copyWith(secondary: kMikadoYellow),
        ),
      ),
    );
  }

  group('Testing Detail Movie Page', () {
    testWidgets(
        'dapat menampilkan CircularProgressIndicator saat state sedang Loading',
        (WidgetTester test) async {
      when(() => mocksDetail.state).thenReturn(BlocMoviesDetailLoading());
      when(() => mocksStatus.state).thenReturn(BlocWatchlistStatusEmpty());
      when(() => mocksAR.state).thenReturn(BlocWatchlistEmpty());

      final circularProgressIndicator = find.byType(CircularProgressIndicator);

      await test.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));
      expect(circularProgressIndicator, findsOneWidget);
    });

    testWidgets('dapat menampilkan Text saat state sedang Error',
        (WidgetTester test) async {
      when(() => mocksDetail.state)
          .thenReturn(const BlocMoviesDetailError('Failed'));
      when(() => mocksStatus.state).thenReturn(BlocWatchlistStatusEmpty());
      when(() => mocksAR.state).thenReturn(BlocWatchlistEmpty());

      final textError = find.text('Failed');

      await test.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));
      expect(textError, findsOneWidget);
    });

    testWidgets(
        'dapat menampilkan Icon Checklist saat state sedang menambahkan Watchlist',
        (WidgetTester test) async {
      when(() => mocksDetail.state)
          .thenReturn(BlocMoviesDetailLoaded(testMovieDetail, testMovieList));
      when(() => mocksStatus.state)
          .thenReturn(const WatchlistMoviesStatus(true));
      when(() => mocksAR.state).thenReturn(BlocWatchlistEmpty());

      final iconChecklist = find.byIcon(Icons.check);

      await test.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));
      expect(iconChecklist, findsOneWidget);
    });

    testWidgets(
        'dapat menampilkan Icon + saat state sedang menghapus Watchlist',
        (WidgetTester test) async {
      when(() => mocksDetail.state)
          .thenReturn(BlocMoviesDetailLoaded(testMovieDetail, testMovieList));
      when(() => mocksStatus.state)
          .thenReturn(const WatchlistMoviesStatus(false));
      when(() => mocksAR.state).thenReturn(BlocWatchlistEmpty());

      final add = find.byIcon(Icons.add);

      await test.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));
      expect(add, findsOneWidget);
    });
  });
}

// Mocks Movie Detail
class MockDetailMovieBloc
    extends MockBloc<BlocMovieDetailEvent, BlocMovieDetailState>
    implements BlocMovieDetailBloc {}

class MovieDetailEventFake extends Fake implements BlocMovieDetailEvent {}

class MovieDetailStateFake extends Fake implements BlocMovieDetailState {}

// Mocks Watchlist Status
class MockWatchlistMovieStatus
    extends MockBloc<BlocWatchlistStatusEvent, BlocWatchlistStatusState>
    implements BlocMovieWatchlistStatus {}

class WatchlistMovieStatusEventFake extends Fake
    implements BlocWatchlistStatusEvent {}

class WatchlistMovieStatusStateFake extends Fake
    implements BlocWatchlistStatusState {}

// Mocks Watchlist Add & Remove
class MockWatchlistMoviesAR
    extends MockBloc<BlocWatchlistAREvent, BlocWatchlistARState>
    implements BlocWatchlistMovieAR {}

class WatchlistMovieAREventFake extends Fake implements BlocWatchlistAREvent {}

class WatchlistMovieARStateFake extends Fake implements BlocWatchlistARState {}
