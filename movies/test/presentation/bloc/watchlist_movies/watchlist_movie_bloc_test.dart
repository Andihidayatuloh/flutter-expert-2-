import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movies/movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../data_dummy/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late MockGetWatchlistMovies mocks;
  late WatchlistMoviesBloc blocs;

  setUp(() {
    mocks = MockGetWatchlistMovies();
    blocs = WatchlistMoviesBloc(mocks);
  });

  group('Testing Top Rated Movies', () {
    test('initial state should be on page', () {
      expect(blocs.state, WatchlistMoviesEmpty());
    });

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      'harus menampilkan [Loading, Data] saat watchlist berhasil ditampilkan',
      build: () {
        when(mocks.execute()).thenAnswer((_) async => Right(testMovieList));
        return blocs;
      },
      act: (bloc) => bloc.add(BlocGetWatchlistMovies()),
      wait: const Duration(milliseconds: 500),
      verify: (_) => BlocGetWatchlistMovies().props,
      expect: () =>
          [WatchlistMoviesLoading(), WatchlistMoviesLoaded(testMovieList)],
    );

    blocTest<WatchlistMoviesBloc, WatchlistMoviesState>(
      ' harus menampilkan [Loading, Error] saat watchlist tidak berhasil dijalankan',
      build: () {
        when(mocks.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return blocs;
      },
      act: (bloc) => bloc.add(BlocGetWatchlistMovies()),
      wait: const Duration(milliseconds: 500),
      verify: (_) => BlocGetWatchlistMovies().props,
      expect: () => [
        WatchlistMoviesLoading(),
        const WatchlistMoviesError('Failed'),
      ],
    );
  });
}
