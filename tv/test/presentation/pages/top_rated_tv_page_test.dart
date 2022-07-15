import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../data_dummy/dummy_objects.dart';

void main() {
  late MockTopRatedTvBloc mocks;

  setUp(() {
    registerFallbackValue(TopRatedTvStateFake());
    registerFallbackValue(TopRatedTvEventFake());
    mocks = MockTopRatedTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>.value(
      value: mocks,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Testing Halaman Top Rated Tv', () {
    testWidgets(
        'dapat menampilkan CircularProgressIndicator saat state sedang Loading ',
        (WidgetTester tester) async {
      when(() => mocks.state).thenReturn(BlocTopRatedTvLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('dapat menampilkan ListView saat data tersedia',
        (WidgetTester tester) async {
      when(() => mocks.state).thenReturn(BlocTopRatedTvLoaded(testTvList));

      final titleText = find.text('Top Rated Tv');
      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(titleText, findsOneWidget);
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('dapat menampilkan text Failed saat sedang Error',
        (WidgetTester tester) async {
      when(() => mocks.state).thenReturn(const BlocTopRatedTvError('Failed'));

      final titleText = find.text('Top Rated Tv');
      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

      expect(titleText, findsOneWidget);
      expect(textFinder, findsOneWidget);
    });
  });
}

// Mocks TopRated Tv
class MockTopRatedTvBloc
    extends MockBloc<BlocTopRatedTvEvent, BlocTopRatedTvState>
    implements TopRatedTvBloc {}

class TopRatedTvEventFake extends Fake implements BlocTopRatedTvEvent {}

class TopRatedTvStateFake extends Fake implements BlocTopRatedTvState {}
