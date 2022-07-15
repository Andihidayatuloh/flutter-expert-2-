import 'package:core/core.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../data_dummy/dummy_objects.dart';

void main() {
  late MockDetailTvBloc mocksDetail;
  late MockWatchlistTvStatus mocksStatus;
  late MockWatchlistTvAR mocksAR;

  setUpAll(() {
    registerFallbackValue(WatchlistTvStatusStateFake());
    registerFallbackValue(WatchlistTvStatusEventFake());
    registerFallbackValue(WatchlistTvAREventFake());
    registerFallbackValue(WatchlistTvARStateFake());
    registerFallbackValue(TvDetailStateFake());
    registerFallbackValue(TvDetailEventFake());
  });

  setUp(() {
    mocksStatus = MockWatchlistTvStatus();
    mocksAR = MockWatchlistTvAR();
    mocksDetail = MockDetailTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocTvWatchlistStatus>.value(
          value: mocksStatus,
        ),
        BlocProvider<BlocWatchlistTvAR>.value(
          value: mocksAR,
        ),
        BlocProvider<BlocTvDetailBloc>.value(
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

  group('Testing Detail Tv Page', () {
    testWidgets(
        'dapat menampilkan CircularProgressIndicator saat state sedang Loading',
        (WidgetTester test) async {
      when(() => mocksDetail.state).thenReturn(BlocTvDetailLoading());
      when(() => mocksStatus.state).thenReturn(BlocTvWatchlistStatusEmpty());
      when(() => mocksAR.state).thenReturn(BloTvWatchlistEmpty());

      final circularProgressIndicator = find.byType(CircularProgressIndicator);

      await test.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));
      expect(circularProgressIndicator, findsOneWidget);
    });

    testWidgets('dapat menampilkan Text saat state sedang Error',
        (WidgetTester test) async {
      when(() => mocksDetail.state)
          .thenReturn(const BlocTvDetailError('Failed'));
      when(() => mocksStatus.state).thenReturn(BlocTvWatchlistStatusEmpty());
      when(() => mocksAR.state).thenReturn(BloTvWatchlistEmpty());

      final textError = find.text('Failed');

      await test.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));
      expect(textError, findsOneWidget);
    });

    testWidgets(
        'dapat menampilkan Icon Checklist saat state sedang menambahkan Watchlist',
        (WidgetTester test) async {
      when(() => mocksDetail.state)
          .thenReturn(BlocTvDetailLoaded(testTvDetail, testTvList));
      when(() => mocksStatus.state).thenReturn(const WatchlistTvStatus(true));
      when(() => mocksAR.state).thenReturn(BloTvWatchlistEmpty());

      final iconChecklist = find.byIcon(Icons.check);

      await test.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));
      expect(iconChecklist, findsOneWidget);
    });

    testWidgets(
        'dapat menampilkan Icon + saat state sedang menghapus Watchlist',
        (WidgetTester test) async {
      when(() => mocksDetail.state)
          .thenReturn(BlocTvDetailLoaded(testTvDetail, testTvList));
      when(() => mocksStatus.state).thenReturn(const WatchlistTvStatus(false));
      when(() => mocksAR.state).thenReturn(BloTvWatchlistEmpty());

      final add = find.byIcon(Icons.add);

      await test.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));
      expect(add, findsOneWidget);
    });
  });
}

// Mocks Tv Detail
class MockDetailTvBloc extends MockBloc<BlocTvDetailEvent, BlocTvDetailState>
    implements BlocTvDetailBloc {}

class TvDetailEventFake extends Fake implements BlocTvDetailEvent {}

class TvDetailStateFake extends Fake implements BlocTvDetailState {}

// Mocks Watchlist Status
class MockWatchlistTvStatus
    extends MockBloc<BlocTvWatchlistStatusEvent, BlocTvWatchlistStatusState>
    implements BlocTvWatchlistStatus {}

class WatchlistTvStatusEventFake extends Fake
    implements BlocTvWatchlistStatusEvent {}

class WatchlistTvStatusStateFake extends Fake
    implements BlocTvWatchlistStatusState {}

// Mocks Watchlist Add & Remove
class MockWatchlistTvAR
    extends MockBloc<BlocTvWatchlistAREvent, BlocTvWatchlistARState>
    implements BlocWatchlistTvAR {}

class WatchlistTvAREventFake extends Fake implements BlocTvWatchlistAREvent {}

class WatchlistTvARStateFake extends Fake implements BlocTvWatchlistARState {}
