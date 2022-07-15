import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../data_dummy/dummy_objects.dart';

void main() {
  late MockWatchlistTvBloc mocks;

  setUp(() {
    registerFallbackValue(WatchlistTvStateFake());
    registerFallbackValue(WatchlistTvEventFake());
    mocks = MockWatchlistTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistTvBloc>.value(
      value: mocks,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Testing Halaman Watchlist Tv', () {
    testWidgets(
        'dapat menampilkan CircularProgressIndicator saat state sedang Loading ',
        (WidgetTester tester) async {
      when(() => mocks.state).thenReturn(WatchlistLoading());
      final progressBarFinder = find.byType(CircularProgressIndicator);
      await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('dapat menampilkan ListView saat data tersedia',
        (WidgetTester tester) async {
      when(() => mocks.state).thenReturn(WatchlistLoaded(testTvList));
      final listViewFinder = find.byType(ListView);
      await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('dapat menampilkan text Failed saat sedang Error',
        (WidgetTester tester) async {
      when(() => mocks.state).thenReturn(const WatchlistError('Failed'));
      final textFinder = find.text('Failed');
      await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));
      expect(textFinder, findsOneWidget);
    });

    testWidgets('dapat menampilkan text Watchlist is Empty saat sedang kosong',
        (WidgetTester tester) async {
      when(() => mocks.state).thenReturn(WatchlistEmpty());
      final textFinder = find.text('Watchlist is Empty');
      await tester.pumpWidget(_makeTestableWidget(WatchlistTvPage()));
      expect(textFinder, findsOneWidget);
    });
  });
}

// Mocks Watchlist Tv
class MockWatchlistTvBloc extends MockBloc<BlocWatchlistTvEvent, WatchlistState>
    implements WatchlistTvBloc {}

class WatchlistTvEventFake extends Fake implements BlocWatchlistTvEvent {}

class WatchlistTvStateFake extends Fake implements WatchlistState {}
