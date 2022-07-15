import 'package:movies/movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../data_dummy/dummy_objects.dart';

void main() {
  late MockTopRatedMoviesBloc mocks;

  setUp(() {
    registerFallbackValue(TopRatedMoviesStateFake());
    registerFallbackValue(TopRatedMoviesEventFake());
    mocks = MockTopRatedMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBloc>.value(
      value: mocks,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Testing Halaman Top Rated Movies', () {
    testWidgets(
        'dapat menampilkan CircularProgressIndicator saat state sedang Loading ',
        (WidgetTester tester) async {
      when(() => mocks.state).thenReturn(BlocTopRatedMoviesLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('dapat menampilkan ListView saat data tersedia',
        (WidgetTester tester) async {
      when(() => mocks.state)
          .thenReturn(BlocTopRatedMoviesLoaded(testMovieList));

      final titleText = find.text('Top Rated Movies');
      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

      expect(titleText, findsOneWidget);
      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('dapat menampilkan text Failed saat sedang Error',
        (WidgetTester tester) async {
      when(() => mocks.state)
          .thenReturn(const BlocTopRatedMoviesError('Failed'));

      final titleText = find.text('Top Rated Movies');
      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

      expect(titleText, findsOneWidget);
      expect(textFinder, findsOneWidget);
    });
  });
}

// Mocks TopRated Movies
class MockTopRatedMoviesBloc
    extends MockBloc<BlocTopRatedMoviesEvent, BlocTopRatedMoviesState>
    implements TopRatedMoviesBloc {}

class TopRatedMoviesEventFake extends Fake implements BlocTopRatedMoviesEvent {}

class TopRatedMoviesStateFake extends Fake implements BlocTopRatedMoviesState {}
