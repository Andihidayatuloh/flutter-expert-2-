import 'package:search/search.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../movies/test/data_dummy/dummy_objects.dart';

// Mocks
class BlocMoviesSearchBlocMocks
    extends MockBloc<BlocMoviesSearchEvent, BlocMoviesSearchState>
    implements BlocMoviesSearchBloc {}

class BlocMoviesSearchEventFake extends Fake implements BlocMoviesSearchEvent {}

class BlocMoviesSearchStateFake extends Fake implements BlocMoviesSearchState {}

// Testing
void main() {
  late final BlocMoviesSearchBlocMocks mocks;

  setUpAll(() {
    registerFallbackValue(BlocMoviesSearchEventFake());
    registerFallbackValue(BlocMoviesSearchStateFake());
    mocks = BlocMoviesSearchBlocMocks();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<BlocMoviesSearchBloc>.value(
      value: mocks,
      child: MaterialApp(home: body),
    );
  }

  group('Testing Halaman Search Movies', () {
    testWidgets(
        'dapat menampilkan CircularProgressIndicator saat state sedang Loading',
        (WidgetTester test) async {
      when(() => mocks.state).thenReturn(BlocMoviesSearchLoading());
      final circularProgress = find.byType(CircularProgressIndicator);
      await test.pumpWidget(_makeTestableWidget(SearchPage()));

      final text = find.byKey(Key('search-textfield'));
      final query = find.text('spiderman');

      await test.enterText(text, 'spiderman');
      await test.testTextInput.receiveAction(TextInputAction.search);

      expect(circularProgress, findsOneWidget);
      expect(query, findsOneWidget);
    });

    testWidgets('dapat menampilkan ListView saat data tersedia',
        (WidgetTester test) async {
      when(() => mocks.state).thenReturn(BlocMoviesSearchLoaded(testMovieList));
      final listViewFinder = find.byType(ListView);
      await test.pumpWidget(_makeTestableWidget(SearchPage()));
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('dapat menampilkan text kosong saat sedang Error',
        (WidgetTester test) async {
      when(() => mocks.state).thenReturn(BlocMoviesSearchError(''));
      await test.pumpWidget(_makeTestableWidget(SearchPage()));

      final tError = find.byKey(Key('search-error'));
      final tField = find.byKey(Key('search-textfield'));
      final query = find.text('spiderman');

      await test.enterText(tField, 'spiderman');
      await test.testTextInput.receiveAction(TextInputAction.search);
      expect(tError, findsOneWidget);
      expect(query, findsOneWidget);
    });

    testWidgets(
        'dapat menampilkan text Data Movies tidak dapat ditemukan saat pencarian',
        (WidgetTester test) async {
      when(() => mocks.state).thenReturn(BlocMoviesSearchLoaded([]));
      await test.pumpWidget(_makeTestableWidget(SearchPage()));

      final tPopUp = find.text('Data Movies tidak dapat ditemukan');
      final tField = find.byKey(Key('search-textfield'));
      final query = find.text('spiderman');

      await test.enterText(tField, 'spiderman');
      await test.testTextInput.receiveAction(TextInputAction.search);
      expect(tPopUp, findsOneWidget);
      expect(query, findsOneWidget);
    });
  });
}
