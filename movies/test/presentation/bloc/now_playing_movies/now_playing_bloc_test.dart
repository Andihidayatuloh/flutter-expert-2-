import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:movies/movies.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../data_dummy/dummy_objects.dart';
import 'now_playing_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
])
void main() {
  late BlocMoviesListBloc blocs;
  late GetNowPlayingMoviesMock mocks;

  setUp(() {
    mocks = GetNowPlayingMoviesMock();
    blocs = BlocMoviesListBloc(mocks);
  });

  group('Testing Now Playing Movies', () {
    test('initial state should be on page', () {
      expect(blocs.state, BlocMoviesEmpty());
    });

    blocTest<BlocMoviesListBloc, BlocMoviesState>(
      'harus menampilkan [Loading, Data] saat now playing berhasil ditampilkan',
      build: () {
        when(mocks.execute()).thenAnswer((_) async => Right(testMovieList));

        return blocs;
      },
      act: (bloc) => bloc.add(BlocGetMoviesEvent()),
      wait: const Duration(milliseconds: 500),
      verify: (_) => BlocGetMoviesEvent().props,
      expect: () => [BlocMoviesLoading(), BlocMoviesLoaded(testMovieList)],
    );

    blocTest<BlocMoviesListBloc, BlocMoviesState>(
      ' harus menampilkan [Loading, Error] saat now playing tidak berhasil dijalankan',
      build: () {
        when(mocks.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));

        return blocs;
      },
      act: (bloc) => bloc.add(BlocGetMoviesEvent()),
      wait: const Duration(milliseconds: 500),
      verify: (_) => BlocGetMoviesEvent().props,
      expect: () => [
        BlocMoviesLoading(),
        const BlocMoviesError('Failed'),
      ],
    );
  });
}
