import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:movies/movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_bloc_test.mocks.dart';
import '../../../data_dummy/dummy_objects.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetTopRatedMovies mocks;
  late TopRatedMoviesBloc blocs;

  setUp(() {
    mocks = MockGetTopRatedMovies();
    blocs = TopRatedMoviesBloc(mocks);
  });

  group('Testing Top Rated Movies', () {
    test('initial state should be on page', () {
      expect(blocs.state, BlocTopRatedMoviesEmpty());
    });

    blocTest<TopRatedMoviesBloc, BlocTopRatedMoviesState>(
      'harus menampilkan [Loading, Data] saat top rated berhasil ditampilkan',
      build: () {
        when(mocks.execute()).thenAnswer((_) async => Right(testMovieList));
        return blocs;
      },
      act: (bloc) => bloc.add(BlocGetTopRatedMoviesEvent()),
      wait: const Duration(milliseconds: 500),
      verify: (_) => BlocGetTopRatedMoviesEvent().props,
      expect: () => [
        BlocTopRatedMoviesLoading(),
        BlocTopRatedMoviesLoaded(testMovieList)
      ],
    );

    blocTest<TopRatedMoviesBloc, BlocTopRatedMoviesState>(
      ' harus menampilkan [Loading, Error] saat top rated tidak berhasil dijalankan',
      build: () {
        when(mocks.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return blocs;
      },
      act: (bloc) => bloc.add(BlocGetTopRatedMoviesEvent()),
      wait: const Duration(milliseconds: 500),
      verify: (_) => BlocGetTopRatedMoviesEvent().props,
      expect: () => [
        BlocTopRatedMoviesLoading(),
        const BlocTopRatedMoviesError('Failed'),
      ],
    );
  });
}
