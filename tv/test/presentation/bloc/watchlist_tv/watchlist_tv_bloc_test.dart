import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../data_dummy/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late MockGetWatchlistTv mocks;
  late WatchlistTvBloc blocs;

  setUp(() {
    mocks = MockGetWatchlistTv();
    blocs = WatchlistTvBloc(mocks);
  });

  group('Testing Top Rated Tv', () {
    test('initial state should be on page', () {
      expect(blocs.state, WatchlistEmpty());
    });

    blocTest<WatchlistTvBloc, WatchlistState>(
      'harus menampilkan [Loading, Data] saat watchlist berhasil ditampilkan',
      build: () {
        when(mocks.execute()).thenAnswer((_) async => Right(testTvList));
        return blocs;
      },
      act: (bloc) => bloc.add(BlocGetWatchlistTv()),
      wait: const Duration(milliseconds: 500),
      verify: (_) => BlocGetWatchlistTv().props,
      expect: () => [WatchlistLoading(), WatchlistLoaded(testTvList)],
    );

    blocTest<WatchlistTvBloc, WatchlistState>(
      ' harus menampilkan [Loading, Error] saat watchlist tidak berhasil dijalankan',
      build: () {
        when(mocks.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return blocs;
      },
      act: (bloc) => bloc.add(BlocGetWatchlistTv()),
      wait: const Duration(milliseconds: 500),
      verify: (_) => BlocGetWatchlistTv().props,
      expect: () => [
        WatchlistLoading(),
        const WatchlistError('Failed'),
      ],
    );
  });
}
