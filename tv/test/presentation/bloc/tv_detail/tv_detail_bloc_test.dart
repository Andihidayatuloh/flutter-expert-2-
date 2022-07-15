import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../data_dummy/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListStatusTv,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late BlocTvDetailBloc blocsTvDetail;
  late MockGetTvDetail mocksDetail;
  late MockGetTvRecommendations mocksRecommendations;

  late BlocTvWatchlistStatus blocsTvStatus;
  late MockGetWatchListStatus mocksWatchlist;

  late BlocWatchlistTvAR blocsTvAR;
  late MockSaveWatchlist mocksSave;
  late MockRemoveWatchlist mocksRemove;

  setUpAll(() {
    mocksDetail = MockGetTvDetail();
    mocksRecommendations = MockGetTvRecommendations();
    mocksWatchlist = MockGetWatchListStatus();
    mocksSave = MockSaveWatchlist();
    mocksRemove = MockRemoveWatchlist();
  });

  setUp(() {
    blocsTvDetail = BlocTvDetailBloc(
      getTvDetail: mocksDetail,
      getTvRecommendations: mocksRecommendations,
    );

    blocsTvStatus = BlocTvWatchlistStatus(
      getWatchListStatus: mocksWatchlist,
    );

    blocsTvAR = BlocWatchlistTvAR(
      removeWatchlist: mocksRemove,
      saveWatchlist: mocksSave,
    );
  });

  group(
    'Testing Detail dan Recommendation Pada Tv',
    () {
      test('initial state should be on page', () {
        expect(blocsTvDetail.state, BlocTvDetailEmpty());
      });

      blocTest<BlocTvDetailBloc, BlocTvDetailState>(
        'harus menampilkan [Loading, Data] saat detail tv berhasil dijalankan',
        build: () {
          when(mocksDetail.execute(1))
              .thenAnswer((_) async => Right(testTvDetail));
          when(mocksRecommendations.execute(1))
              .thenAnswer((_) async => Right(testTvList));
          return blocsTvDetail;
        },
        act: (bloc) => bloc.add(const FetchTvDetail(1)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => const FetchTvDetail(1).props,
        expect: () => [
          BlocTvDetailLoading(),
          BlocTvDetailLoaded(testTvDetail, testTvList)
        ],
      );

      blocTest<BlocTvDetailBloc, BlocTvDetailState>(
        ' harus menampilkan [Loading, Error] disaat detail tv tidak berhasil dijalankan',
        build: () {
          when(mocksDetail.execute(1))
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          when(mocksRecommendations.execute(1))
              .thenAnswer((_) async => Right(testTvList));
          return blocsTvDetail;
        },
        act: (bloc) => bloc.add(const FetchTvDetail(1)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => const FetchTvDetail(1).props,
        expect: () => [
          BlocTvDetailLoading(),
          const BlocTvDetailError('Failed'),
        ],
      );

      blocTest<BlocTvDetailBloc, BlocTvDetailState>(
        ' harus menampilkan [Loading, Error] disaat rekomendasi tv tidak dapat dijalankan',
        build: () {
          when(mocksDetail.execute(1))
              .thenAnswer((_) async => Right(testTvDetail));
          when(mocksRecommendations.execute(1))
              .thenAnswer((_) async => Left(ServerFailure('Failed')));
          return blocsTvDetail;
        },
        act: (bloc) => bloc.add(const FetchTvDetail(1)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => const FetchTvDetail(1).props,
        expect: () =>
            [BlocTvDetailLoading(), const BlocTvDetailError('Failed')],
      );
    },
  );

  group(
    'Testing Watchlist Status Pada Tv',
    () {
      test('initial state should be on page', () {
        expect(blocsTvStatus.state, BlocTvWatchlistStatusEmpty());
      });

      blocTest<BlocTvWatchlistStatus, BlocTvWatchlistStatusState>(
        'harus menampilkan [Loading, Data] saat data berhasil dijalankan',
        build: () {
          when(mocksWatchlist.execute(1)).thenAnswer((_) async => true);
          return blocsTvStatus;
        },
        act: (bloc) => bloc.add(const LoadWatchlistTvStatus(1)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => const LoadWatchlistTvStatus(1).props,
        expect: () =>
            [BlocTvWatchlistStatusLoading(), const WatchlistTvStatus(true)],
      );

      blocTest<BlocTvWatchlistStatus, BlocTvWatchlistStatusState>(
        'harus menampilkan [Loading, Error] saat data tidak berhasil dijalankan',
        build: () {
          when(mocksWatchlist.execute(1)).thenAnswer((_) async => false);
          return blocsTvStatus;
        },
        act: (bloc) => bloc.add(const LoadWatchlistTvStatus(1)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => const LoadWatchlistTvStatus(1).props,
        expect: () =>
            [BlocTvWatchlistStatusLoading(), const WatchlistTvStatus(false)],
      );
    },
  );

  const save = 'Added to Watchlist';
  const remove = 'Removed from Watchlist';
  const failed = 'Failed';

  group(
    'Testing Watchlist untuk Menambahkan dan Menghapus Tv',
    () {
      test('initial state should be on page', () {
        expect(blocsTvAR.state, BloTvWatchlistEmpty());
      });

      blocTest<BlocWatchlistTvAR, BlocTvWatchlistARState>(
        'harus menampilkan [Loading, Data] saat menambah tv berhasil dijalankan',
        build: () {
          when(mocksSave.execute(testTvDetail))
              .thenAnswer((_) async => const Right(save));
          return blocsTvAR;
        },
        act: (bloc) => bloc.add(AddWatchlistTv(testTvDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => AddWatchlistTv(testTvDetail).props,
        expect: () =>
            [BlocTvWatchlistLoading(), const TvWatchlistAddMessage(save)],
      );

      blocTest<BlocWatchlistTvAR, BlocTvWatchlistARState>(
        'should emit [Loading, Data] when save tv is gotten unsuccessfully',
        build: () {
          when(mocksSave.execute(testTvDetail))
              .thenAnswer((_) async => Left(DatabaseFailure(failed)));
          return blocsTvAR;
        },
        act: (bloc) => bloc.add(AddWatchlistTv(testTvDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => AddWatchlistTv(testTvDetail).props,
        expect: () =>
            [BlocTvWatchlistLoading(), const BlocTvWatchlistError(failed)],
      );

      blocTest<BlocWatchlistTvAR, BlocTvWatchlistARState>(
        'should emit [Loading, Data] when remove tv is gotten successfully',
        build: () {
          when(mocksRemove.execute(testTvDetail))
              .thenAnswer((_) async => const Right(remove));
          return blocsTvAR;
        },
        act: (bloc) => bloc.add(RemoveFromWatchlistTv(testTvDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => RemoveFromWatchlistTv(testTvDetail).props,
        expect: () =>
            [BlocTvWatchlistLoading(), const TvWatchlistRemoveMessage(remove)],
      );

      blocTest<BlocWatchlistTvAR, BlocTvWatchlistARState>(
        'should emit [Loading, Data] when remove tv is gotten unsuccessfully',
        build: () {
          when(mocksRemove.execute(testTvDetail))
              .thenAnswer((_) async => Left(DatabaseFailure(failed)));
          return blocsTvAR;
        },
        act: (bloc) => bloc.add(RemoveFromWatchlistTv(testTvDetail)),
        wait: const Duration(milliseconds: 500),
        verify: (_) => RemoveFromWatchlistTv(testTvDetail).props,
        expect: () =>
            [BlocTvWatchlistLoading(), const BlocTvWatchlistError(failed)],
      );
    },
  );
}
