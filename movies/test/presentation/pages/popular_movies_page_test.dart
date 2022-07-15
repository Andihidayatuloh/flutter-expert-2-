import 'package:movies/movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../data_dummy/dummy_objects.dart';

void main() {
  late MockPopularMoviesBloc mocks;

  setUp(() {
    registerFallbackValue(PopularMoviesStateFake());
    registerFallbackValue(PopularMoviesEventFake());
    mocks = MockPopularMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<BlocPopularMoviesBloc>.value(
      value: mocks,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Testing Halaman Popular Movies', () {
    testWidgets(
        'dapat menampilkan CircularProgressIndicator saat state sedang Loading ',
        (WidgetTester tester) async {
      when(() => mocks.state).thenReturn(BlocPopularMoviesLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('dapat menampilkan ListView saat data tersedia',
        (WidgetTester tester) async {
      when(() => mocks.state)
          .thenReturn(BlocPopularMoviesLoaded(testMovieList));

      final titleText = find.text('Popular Movies');
      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

      expect(titleText, findsOneWidget);
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('dapat menampilkan text Failed saat sedang Error',
        (WidgetTester tester) async {
      when(() => mocks.state)
          .thenReturn(const BlocPopularMoviesError('Failed'));

      final titleText = find.text('Popular Movies');
      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

      expect(titleText, findsOneWidget);
      expect(textFinder, findsOneWidget);
    });
  });
}

// Mocks Popular Movies
class MockPopularMoviesBloc
    extends MockBloc<BlocPopularMoviesEvent, BlocPopularMoviesState>
    implements BlocPopularMoviesBloc {}

class PopularMoviesEventFake extends Fake implements BlocPopularMoviesEvent {}

class PopularMoviesStateFake extends Fake implements BlocPopularMoviesState {}
