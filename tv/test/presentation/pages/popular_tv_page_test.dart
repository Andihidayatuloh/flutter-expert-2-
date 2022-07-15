import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../data_dummy/dummy_objects.dart';

void main() {
  late MockPopularTvBloc mocks;

  setUp(() {
    registerFallbackValue(PopularTvStateFake());
    registerFallbackValue(PopularTvEventFake());
    mocks = MockPopularTvBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<BlocPopularTvBloc>.value(
      value: mocks,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Testing Halaman Popular Tv', () {
    testWidgets(
        'dapat menampilkan CircularProgressIndicator saat state sedang Loading ',
        (WidgetTester tester) async {
      when(() => mocks.state).thenReturn(BlocPopularTvLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('dapat menampilkan ListView saat data tersedia',
        (WidgetTester tester) async {
      when(() => mocks.state).thenReturn(BlocPopularTvLoaded(testTvList));

      final titleText = find.text('Popular Tv');
      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

      expect(titleText, findsOneWidget);
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('dapat menampilkan text Failed saat sedang Error',
        (WidgetTester tester) async {
      when(() => mocks.state).thenReturn(const BlocPopularTvError('Failed'));

      final titleText = find.text('Popular Tv');
      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

      expect(titleText, findsOneWidget);
      expect(textFinder, findsOneWidget);
    });
  });
}

// Mocks Popular Tv
class MockPopularTvBloc extends MockBloc<BlocPopularTvEvent, BlocPopularTvState>
    implements BlocPopularTvBloc {}

class PopularTvEventFake extends Fake implements BlocPopularTvEvent {}

class PopularTvStateFake extends Fake implements BlocPopularTvState {}
