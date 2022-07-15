import 'package:search/search.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../tv/test/data_dummy/dummy_objects.dart';

// Mocks
class BlocTvSearchBlocMocks
    extends MockBloc<BlocTvSearchEvent, BlocTvSearchState>
    implements BlocTvSearchBloc {}

class BlocTvSearchEventFake extends Fake implements BlocTvSearchEvent {}

class BlocTvSearchStateFake extends Fake implements BlocTvSearchState {}

// Testing
void main() {
  late final BlocTvSearchBlocMocks mocks;

  setUpAll(() {
    registerFallbackValue(BlocTvSearchEventFake());
    registerFallbackValue(BlocTvSearchStateFake());
    mocks = BlocTvSearchBlocMocks();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<BlocTvSearchBloc>.value(
      value: mocks,
      child: MaterialApp(home: body),
    );
  }

  group('Testing Halaman Search Tv', () {
    testWidgets(
        'dapat menampilkan CircularProgressIndicator saat state sedang Loading',
        (WidgetTester test) async {
      when(() => mocks.state).thenReturn(BlocTvSearchLoading());
      final circularProgress = find.byType(CircularProgressIndicator);
      await test.pumpWidget(_makeTestableWidget(SearchTvPage()));

      final text = find.byKey(Key('search-textfield'));
      final query = find.text('doraemon');

      await test.enterText(text, 'doraemon');
      await test.testTextInput.receiveAction(TextInputAction.search);

      expect(circularProgress, findsOneWidget);
      expect(query, findsOneWidget);
    });

    testWidgets('dapat menampilkan ListView saat data tersedia',
        (WidgetTester test) async {
      when(() => mocks.state).thenReturn(BlocTvSearchLoaded(testTvList));
      final listViewFinder = find.byType(ListView);
      await test.pumpWidget(_makeTestableWidget(SearchTvPage()));
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('dapat menampilkan text kosong saat sedang Error',
        (WidgetTester test) async {
      when(() => mocks.state).thenReturn(BlocTvSearchError(''));
      await test.pumpWidget(_makeTestableWidget(SearchTvPage()));

      final tError = find.byKey(Key('search-error'));
      final tField = find.byKey(Key('search-textfield'));
      final query = find.text('doraemon');

      await test.enterText(tField, 'doraemon');
      await test.testTextInput.receiveAction(TextInputAction.search);
      expect(tError, findsOneWidget);
      expect(query, findsOneWidget);
    });

    testWidgets(
        'dapat menampilkan text Data Tv tidak dapat ditemukan saat pencarian',
        (WidgetTester test) async {
      when(() => mocks.state).thenReturn(BlocTvSearchLoaded([]));
      await test.pumpWidget(_makeTestableWidget(SearchTvPage()));

      final tPopUp = find.text('Data Tv tidak dapat ditemukan');
      final tField = find.byKey(Key('search-textfield'));
      final query = find.text('doraemon');

      await test.enterText(tField, 'doraemon');
      await test.testTextInput.receiveAction(TextInputAction.search);
      expect(tPopUp, findsOneWidget);
      expect(query, findsOneWidget);
    });
  });
}
