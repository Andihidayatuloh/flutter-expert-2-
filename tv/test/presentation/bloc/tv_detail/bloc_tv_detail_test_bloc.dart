import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'bloc_tv_detail_tes_mock.dart';


@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListStatusTv,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  late BlocTvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendation mockGetTvRecommendation;
  late MockGetWatchListTvStatus mockGetWatchlistStatus;
  late MockSaveWatchlistTv mockSaveWatchlist;
  late MockRemoveWatchlistTv mockRemoveWatchlist;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendation = MockGetTvRecommendation();
    mockGetWatchlistStatus = MockGetWatchListTvStatus();
    mockSaveWatchlist = MockSaveWatchlistTv();
    mockRemoveWatchlist = MockRemoveWatchlistTv();
    tvDetailBloc = BlocTvDetailBloc(
      getTvDetail: mockGetTvDetail,
      getTvRecommendation: mockGetTvRecommendation,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  final tvStateInit = TvDetailState.initial();
  final tTvs = <Tv>[testTv];

  group('Get Tv Detail', () {
    blocTest<BlocTvDetailBloc, TvDetailState>(
        'should emit TvDetailLoading, RecommendationLoading, TvDetailLoaded and RecommendationLoaded when get Detail Tvs and Recommendation Success',
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => const Right(testTvDetail));
          when(mockGetTvRecommendation.execute(tId))
              .thenAnswer((_) async => Right(tTvs));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchTvDetail(tId)),
        expect: () => [
              tvStateInit.copyWith(tvState: RequestState.Loading),
              tvStateInit.copyWith(
                recommendationState: RequestState.Loading,
                tvDetail: testTvDetail,
                tvState: RequestState.Loaded,
                message: '',
              ),
              tvStateInit.copyWith(
                tvState: RequestState.Loaded,
                tvDetail: testTvDetail,
                recommendationState: RequestState.Loaded,
                tvRecommendations: tTvs,
                message: '',
              ),
            ],
        verify: (_) {
          verify(mockGetTvDetail.execute(tId));
          verify(mockGetTvRecommendation.execute(tId));
        });

    blocTest<BlocTvDetailBloc, TvDetailState>(
        'should emit TvDetailLoading, RecommendationLoading, TvDetailLoaded and RecommendationError when get TvRecommendations Failed',
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => const Right(testTvDetail));
          when(mockGetTvRecommendation.execute(tId))
              .thenAnswer((_) async => Left(ConnectionFailure('Failed')));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchTvDetail(tId)),
        expect: () => [
              tvStateInit.copyWith(tvState: RequestState.Loading),
              tvStateInit.copyWith(
                recommendationState: RequestState.Loading,
                tvDetail: testTvDetail,
                tvState: RequestState.Loaded,
                message: '',
              ),
              tvStateInit.copyWith(
                tvState: RequestState.Loaded,
                tvDetail: testTvDetail,
                recommendationState: RequestState.Error,
                message: 'Failed',
              ),
            ],
        verify: (_) {
          verify(mockGetTvDetail.execute(tId));
          verify(mockGetTvRecommendation.execute(tId));
        });

    blocTest<BlocTvDetailBloc, TvDetailState>(
        'should emit TvDetailError when Get Tv Detail Failed',
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => Left(ConnectionFailure('Failed')));
          when(mockGetTvRecommendation.execute(tId))
              .thenAnswer((_) async => Right(tTvs));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const FetchTvDetail(tId)),
        expect: () => [
              tvStateInit.copyWith(tvState: RequestState.Loading),
              tvStateInit.copyWith(
                tvState: RequestState.Error,
                message: 'Failed',
              ),
            ],
        verify: (_) {
          verify(mockGetTvDetail.execute(tId));
          verify(mockGetTvRecommendation.execute(tId));
        });
  });

  group('AddWatchlist', () {
    blocTest<BlocTvDetailBloc, TvDetailState>(
        'should emit WatchlistMessage and isAddedToWatchlist True when Success AddWatchlist',
        build: () {
          when(mockSaveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => const Right('Added to Watchlist'));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => true);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const AddWatchlist(testTvDetail)),
        expect: () => [
              tvStateInit.copyWith(watchlistMessage: 'Added to Watchlist'),
              tvStateInit.copyWith(
                watchlistMessage: 'Added to Watchlist',
                isAddedToWatchlist: true,
              ),
            ],
        verify: (_) {
          verify(mockSaveWatchlist.execute(testTvDetail));
          verify(mockGetWatchlistStatus.execute(testTvDetail.id));
        });

    blocTest<BlocTvDetailBloc, TvDetailState>(
        'should emit WatchlistMessage when Failed',
        build: () {
          when(mockSaveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async =>  Left(DatabaseFailure('Failed')));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const AddWatchlist(testTvDetail)),
        expect: () => [
              tvStateInit.copyWith(watchlistMessage: 'Failed'),
            ],
        verify: (_) {
          verify(mockSaveWatchlist.execute(testTvDetail));
          verify(mockGetWatchlistStatus.execute(testTvDetail.id));
        });
  });

  group('RemoveFromWatchlist', () {
    blocTest<BlocTvDetailBloc, TvDetailState>(
        'should emit WatchlistMessage and isAddedToWatchlist True when Success RemoveFromWatchlist',
        build: () {
          when(mockRemoveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => const Right('Removed From Watchlist'));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const RemoveFromWatchlist(testTvDetail)),
        expect: () => [
              tvStateInit.copyWith(watchlistMessage: 'Removed From Watchlist'),
            ],
        verify: (_) {
          verify(mockRemoveWatchlist.execute(testTvDetail));
          verify(mockGetWatchlistStatus.execute(testTvDetail.id));
        });

    blocTest<BlocTvDetailBloc, TvDetailState>(
        'should emit WatchlistMessage when Failed',
        build: () {
          when(mockRemoveWatchlist.execute(testTvDetail))
              .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
          when(mockGetWatchlistStatus.execute(testTvDetail.id))
              .thenAnswer((_) async => false);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const RemoveFromWatchlist(testTvDetail)),
        expect: () => [
              tvStateInit.copyWith(watchlistMessage: 'Failed'),
            ],
        verify: (_) {
          verify(mockRemoveWatchlist.execute(testTvDetail));
          verify(mockGetWatchlistStatus.execute(testTvDetail.id));
        });
  });

  group('LoadWatchlistStatus', () {
    blocTest<BlocTvDetailBloc, TvDetailState>('should emit AddWatchlistStatus true',
        build: () {
          when(mockGetWatchlistStatus.execute(tId))
              .thenAnswer((_) async => true);
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(const LoadWatchlistStatus(tId)),
        expect: () => [
              tvStateInit.copyWith(isAddedToWatchlist: true),
            ],
        verify: (_) {
          verify(mockGetWatchlistStatus.execute(testTvDetail.id));
        });
  });
}
