import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../data_dummy/dummy_objects.dart';
import 'now_playing_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingTv,
])
void main() {
  late BlocTvListBloc blocs;
  late GetNowPlayingTvMock mocks;

  setUp(() {
    mocks = GetNowPlayingTvMock();
    blocs = BlocTvListBloc(mocks);
  });

  group('Testing Now Playing Tv', () {
    test('initial state should be on page', () {
      expect(blocs.state, BlocTvEmpty());
    });

    blocTest<BlocTvListBloc, BlocTvState>(
      'harus menampilkan [Loading, Data] saat now playing berhasil ditampilkan',
      build: () {
        when(mocks.execute()).thenAnswer((_) async => Right(testTvList));

        return blocs;
      },
      act: (bloc) => bloc.add(BlocGetTvEvent()),
      wait: const Duration(milliseconds: 500),
      verify: (_) => BlocGetTvEvent().props,
      expect: () => [BlocTvLoading(), BlocTvLoaded(testTvList)],
    );

    blocTest<BlocTvListBloc, BlocTvState>(
      ' harus menampilkan [Loading, Error] saat now playing tidak berhasil dijalankan',
      build: () {
        when(mocks.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));

        return blocs;
      },
      act: (bloc) => bloc.add(BlocGetTvEvent()),
      wait: const Duration(milliseconds: 500),
      verify: (_) => BlocGetTvEvent().props,
      expect: () => [
        BlocTvLoading(),
        const BlocTvError('Failed'),
      ],
    );
  });
}
