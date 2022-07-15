import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movies/movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_bloc_test.mocks.dart';
import '../../../data_dummy/dummy_objects.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mocks;
  late BlocPopularMoviesBloc blocs;

  setUp(() {
    mocks = MockGetPopularMovies();
    blocs = BlocPopularMoviesBloc(mocks);
  });

  group('Testing Popular Movies', () {
    test('initial state should be on page', () {
      expect(blocs.state, BlocPopularMoviesEmpty());
    });

    blocTest<BlocPopularMoviesBloc, BlocPopularMoviesState>(
      'harus menampilkan [Loading, Data] saat popular berhasil ditampilkan',
      build: () {
        when(mocks.execute()).thenAnswer((_) async => Right(testMovieList));
        return blocs;
      },
      act: (bloc) => bloc.add(BlocGetPopularMoviesEvent()),
      wait: const Duration(milliseconds: 500),
      verify: (_) => BlocGetPopularMoviesEvent().props,
      expect: () =>
          [BlocPopularMoviesLoading(), BlocPopularMoviesLoaded(testMovieList)],
    );

    blocTest<BlocPopularMoviesBloc, BlocPopularMoviesState>(
      ' harus menampilkan [Loading, Error] saat popular tidak berhasil dijalankan',
      build: () {
        when(mocks.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return blocs;
      },
      act: (bloc) => bloc.add(BlocGetPopularMoviesEvent()),
      wait: const Duration(milliseconds: 500),
      verify: (_) => BlocGetPopularMoviesEvent().props,
      expect: () => [
        BlocPopularMoviesLoading(),
        const BlocPopularMoviesError('Failed'),
      ],
    );
  });
}
