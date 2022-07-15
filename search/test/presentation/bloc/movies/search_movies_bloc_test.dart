import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:search/search.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'search_movies_bloc_test.mocks.dart';

import '../../../../../movies/test/data_dummy/dummy_objects.dart';

@GenerateMocks([SearchMovies])
void main() {
  late BlocMoviesSearchBloc blocs;
  late SearchMoviesMocks mocks;

  setUpAll(() {
    mocks = SearchMoviesMocks();
    blocs = BlocMoviesSearchBloc(search: mocks);
  });

  group('Test Search Movies', () {
    test('state harus sudah kosong', () {
      expect(blocs.state, BlocMoviesSearchEmpty());
    });

    blocTest<BlocMoviesSearchBloc, BlocMoviesSearchState>(
      'harus menampilkan [Loading, Data] saat data pencarian sudah didapatkan',
      build: () {
        when(mocks.execute(queryMovie))
            .thenAnswer((_) async => Right(movieList));
        return blocs;
      },
      act: (bloc) => bloc.add(OnQueryMoviesChanged(queryMovie)),
      wait: const Duration(milliseconds: 500),
      expect: () {
        [BlocMoviesSearchLoading(), BlocMoviesSearchLoaded(movieList)];
      },
      verify: (bloc) => verify(mocks.execute(queryMovie)),
    );

    blocTest<BlocMoviesSearchBloc, BlocMoviesSearchState>(
      'harus menampilkan [Loading, Error] saat data pencarian gagal didapatkan',
      build: () {
        when(mocks.execute(queryMovie))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return blocs;
      },
      act: (bloc) => bloc.add(OnQueryMoviesChanged(queryMovie)),
      wait: const Duration(milliseconds: 500),
      expect: () {
        [BlocMoviesSearchLoading(), BlocMoviesSearchError('Server Failure')];
      },
      verify: (bloc) => verify(mocks.execute(queryMovie)),
    );
  });
}
