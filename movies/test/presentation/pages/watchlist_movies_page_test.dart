import 'package:movies/movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../data_dummy/dummy_objects.dart';

void main() {
  late MockWatchlistMoviesBloc mocks;

  setUp(() {
    registerFallbackValue(WatchlistMoviesStateFake());
    registerFallbackValue(WatchlistMoviesEventFake());
    mocks = MockWatchlistMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistMoviesBloc>.value(
      value: mocks,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Testing Halaman Watchlist Movies', () {
    testWidgets(
        'dapat menampilkan CircularProgressIndicator saat state sedang Loading ',
        (WidgetTester tester) async {
      when(() => mocks.state).thenReturn(WatchlistMoviesLoading());
      final progressBarFinder = find.byType(CircularProgressIndicator);
      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('dapat menampilkan ListView saat data tersedia',
        (WidgetTester tester) async {
      when(() => mocks.state).thenReturn(WatchlistMoviesLoaded(testMovieList));
      final listViewFinder = find.byType(ListView);
      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('dapat menampilkan text Failed saat sedang Error',
        (WidgetTester tester) async {
      when(() => mocks.state).thenReturn(const WatchlistMoviesError('Failed'));
      final textFinder = find.text('Failed');
      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));
      expect(textFinder, findsOneWidget);
    });

    testWidgets('dapat menampilkan text Watchlist is Empty saat sedang kosong',
        (WidgetTester tester) async {
      when(() => mocks.state).thenReturn(WatchlistMoviesEmpty());
      final textFinder = find.text('Watchlist is Empty');
      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));
      expect(textFinder, findsOneWidget);
    });
  });
}

// Mocks Watchlist Movies
class MockWatchlistMoviesBloc
    extends MockBloc<BlocWatchlistMoviesEvent, WatchlistMoviesState>
    implements WatchlistMoviesBloc {}

class WatchlistMoviesEventFake extends Fake
    implements BlocWatchlistMoviesEvent {}

class WatchlistMoviesStateFake extends Fake implements WatchlistMoviesState {}
