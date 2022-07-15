import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:movies/movies.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../data_dummy/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late BlocMovieDetailBloc blocsMovieDetail;
  late MockGetMovieDetail mocksDetail;
  late MockGetMovieRecommendations mocksRecommendations;

  late BlocMovieWatchlistStatus blocsMovieStatus;
  late MockGetWatchListStatus mocksWatchlist;

  late BlocWatchlistMovieAR blocsMovieAR;
  late MockSaveWatchlist mocksSave;
  late MockRemoveWatchlist mocksRemove;

  setUpAll(() {
    mocksDetail = MockGetMovieDetail();
    mocksRecommendations = MockGetMovieRecommendations();
    mocksWatchlist = MockGetWatchListStatus();
    mocksSave = MockSaveWatchlist();
    mocksRemove = MockRemoveWatchlist();
  });

  setUp(() {
    blocsMovieDetail = BlocMovieDetailBloc(
      getMovieDetail: mocksDetail,
      getMovieRecommendations: mocksRecommendations,
    );

    blocsMovieStatus = BlocMovieWatchlistStatus(
      getWatchListStatus: mocksWatchlist,
    );

    blocsMovieAR = BlocWatchlistMovieAR(
      removeWatchlist: mocksRemove,
      saveWatchlist: mocksSave,
    );
  });

  group(
    'Testing Detail dan Recommendation Pada Movies',
    () {
      test('initial state should be on page', () {
        expect(blocsMovieDetail.state, BlocMoviesDetailEmpty());
      });

      blocTest<BlocMovieDetailBloc, BlocMovieDetailState>(
        'harus menampilkan [Loading, Data] saat detail movie berhasil dijalankan',
        build: () {
          when(mocksDetail.execute(1))
              .thenAnswer((_) async => Right(testMovieDetail));
          when(mocksRecommendations.execute(1))
              .thenAnswer((_) async => Right(testMovieList));
          return blocsMovieDetail;
        },
        act: (bloc) => bloc.add(const FetchMovieDetail(1)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => const FetchMovieDetail(1).props,
        expect: () => [
          BlocMoviesDetailLoading(),
          BlocMoviesDetailLoaded(testMovieDetail, testMovieList)
        ],
      );

      blocTest<BlocMovieDetailBloc, BlocMovieDetailState>(
        ' harus menampilkan [Loading, Error] disaat detail movie tidak berhasil dijalankan',
        build: () {
          when(mocksDetail.execute(1))
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          when(mocksRecommendations.execute(1))
              .thenAnswer((_) async => Right(testMovieList));
          return blocsMovieDetail;
        },
        act: (bloc) => bloc.add(const FetchMovieDetail(1)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => const FetchMovieDetail(1).props,
        expect: () => [
          BlocMoviesDetailLoading(),
          const BlocMoviesDetailError('Failed'),
        ],
      );

      blocTest<BlocMovieDetailBloc, BlocMovieDetailState>(
        ' harus menampilkan [Loading, Error] disaat rekomendasi movie tidak dapat dijalankan',
        build: () {
          when(mocksDetail.execute(1))
              .thenAnswer((_) async => Right(testMovieDetail));
          when(mocksRecommendations.execute(1))
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return blocsMovieDetail;
        },
        act: (bloc) => bloc.add(const FetchMovieDetail(1)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => const FetchMovieDetail(1).props,
        expect: () =>
            [BlocMoviesDetailLoading(), const BlocMoviesDetailError('Failed')],
      );
    },
  );

  group(
    'Testing Watchlist Status Pada Movies',
    () {
      test('initial state should be on page', () {
        expect(blocsMovieStatus.state, BlocWatchlistStatusEmpty());
      });

      blocTest<BlocMovieWatchlistStatus, BlocWatchlistStatusState>(
        'harus menampilkan [Loading, Data] saat data berhasil dijalankan',
        build: () {
          when(mocksWatchlist.execute(1)).thenAnswer((_) async => true);
          return blocsMovieStatus;
        },
        act: (bloc) => bloc.add(const LoadWatchlistMoviesStatus(1)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => const LoadWatchlistMoviesStatus(1).props,
        expect: () =>
            [BlocWatchlistStatusLoading(), const WatchlistMoviesStatus(true)],
      );

      blocTest<BlocMovieWatchlistStatus, BlocWatchlistStatusState>(
        'harus menampilkan [Loading, Error] saat data tidak berhasil dijalankan',
        build: () {
          when(mocksWatchlist.execute(1)).thenAnswer((_) async => false);
          return blocsMovieStatus;
        },
        act: (bloc) => bloc.add(const LoadWatchlistMoviesStatus(1)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => const LoadWatchlistMoviesStatus(1).props,
        expect: () =>
            [BlocWatchlistStatusLoading(), const WatchlistMoviesStatus(false)],
      );
    },
  );

  const save = 'Added to Watchlist';
  const remove = 'Removed from Watchlist';
  const failed = 'Failed';

  group(
    'Testing Watchlist untuk Menambahkan dan Menghapus Movies',
    () {
      test('initial state should be on page', () {
        expect(blocsMovieAR.state, BlocWatchlistEmpty());
      });

      blocTest<BlocWatchlistMovieAR, BlocWatchlistARState>(
        'harus menampilkan [Loading, Data] saat menambah movie berhasil dijalankan',
        build: () {
          when(mocksSave.execute(testMovieDetail))
              .thenAnswer((_) async => const Right(save));
          return blocsMovieAR;
        },
        act: (bloc) => bloc.add(AddWatchlistMovies(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => AddWatchlistMovies(testMovieDetail).props,
        expect: () => [BlocWatchlistLoading(), const WatchlistAddMessage(save)],
      );

      blocTest<BlocWatchlistMovieAR, BlocWatchlistARState>(
        'should emit [Loading, Data] when save movie is gotten unsuccessfully',
        build: () {
          when(mocksSave.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure(failed)));
          return blocsMovieAR;
        },
        act: (bloc) => bloc.add(AddWatchlistMovies(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => AddWatchlistMovies(testMovieDetail).props,
        expect: () =>
            [BlocWatchlistLoading(), const BlocWatchlistError(failed)],
      );

      blocTest<BlocWatchlistMovieAR, BlocWatchlistARState>(
        'should emit [Loading, Data] when remove movie is gotten successfully',
        build: () {
          when(mocksRemove.execute(testMovieDetail))
              .thenAnswer((_) async => const Right(remove));
          return blocsMovieAR;
        },
        act: (bloc) => bloc.add(RemoveFromWatchlistMovies(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => RemoveFromWatchlistMovies(testMovieDetail).props,
        expect: () =>
            [BlocWatchlistLoading(), const WatchlistRemoveMessage(remove)],
      );

      blocTest<BlocWatchlistMovieAR, BlocWatchlistARState>(
        'should emit [Loading, Data] when remove movie is gotten unsuccessfully',
        build: () {
          when(mocksRemove.execute(testMovieDetail))
              .thenAnswer((_) async => Left(DatabaseFailure(failed)));
          return blocsMovieAR;
        },
        act: (bloc) => bloc.add(RemoveFromWatchlistMovies(testMovieDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => RemoveFromWatchlistMovies(testMovieDetail).props,
        expect: () =>
            [BlocWatchlistLoading(), const BlocWatchlistError(failed)],
      );
    },
  );
}
