import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_bloc_test.mocks.dart';
import '../../../data_dummy/dummy_objects.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetTopRatedTv mocks;
  late TopRatedTvBloc blocs;

  setUp(() {
    mocks = MockGetTopRatedTv();
    blocs = TopRatedTvBloc(mocks);
  });

  group('Testing Top Rated Tv', () {
    test('initial state should be on page', () {
      expect(blocs.state, BlocTopRatedTvEmpty());
    });

    blocTest<TopRatedTvBloc, BlocTopRatedTvState>(
      'harus menampilkan [Loading, Data] saat top rated berhasil ditampilkan',
      build: () {
        when(mocks.execute()).thenAnswer((_) async => Right(testTvList));
        return blocs;
      },
      act: (bloc) => bloc.add(BlocGetTopRatedTvEvent()),
      wait: const Duration(milliseconds: 500),
      verify: (_) => BlocGetTopRatedTvEvent().props,
      expect: () => [BlocTopRatedTvLoading(), BlocTopRatedTvLoaded(testTvList)],
    );

    blocTest<TopRatedTvBloc, BlocTopRatedTvState>(
      ' harus menampilkan [Loading, Error] saat top rated tidak berhasil dijalankan',
      build: () {
        when(mocks.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return blocs;
      },
      act: (bloc) => bloc.add(BlocGetTopRatedTvEvent()),
      wait: const Duration(milliseconds: 500),
      verify: (_) => BlocGetTopRatedTvEvent().props,
      expect: () => [
        BlocTopRatedTvLoading(),
        const BlocTopRatedTvError('Failed'),
      ],
    );
  });
}
