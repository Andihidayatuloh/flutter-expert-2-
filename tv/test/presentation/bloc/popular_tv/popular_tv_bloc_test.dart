import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_bloc_test.mocks.dart';
import '../../../data_dummy/dummy_objects.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mocks;
  late BlocPopularTvBloc blocs;

  setUp(() {
    mocks = MockGetPopularTv();
    blocs = BlocPopularTvBloc(mocks);
  });

  group('Testing Popular Tv', () {
    test('initial state should be on page', () {
      expect(blocs.state, BlocPopularTvEmpty());
    });

    blocTest<BlocPopularTvBloc, BlocPopularTvState>(
      'harus menampilkan [Loading, Data] saat popular berhasil ditampilkan',
      build: () {
        when(mocks.execute()).thenAnswer((_) async => Right(testTvList));
        return blocs;
      },
      act: (bloc) => bloc.add(BlocGetPopularTvEvent()),
      wait: const Duration(milliseconds: 500),
      verify: (_) => BlocGetPopularTvEvent().props,
      expect: () => [BlocPopularTvLoading(), BlocPopularTvLoaded(testTvList)],
    );

    blocTest<BlocPopularTvBloc, BlocPopularTvState>(
      ' harus menampilkan [Loading, Error] saat popular tidak berhasil dijalankan',
      build: () {
        when(mocks.execute())
            .thenAnswer((_) async => Left(ServerFailure('Failed')));
        return blocs;
      },
      act: (bloc) => bloc.add(BlocGetPopularTvEvent()),
      wait: const Duration(milliseconds: 500),
      verify: (_) => BlocGetPopularTvEvent().props,
      expect: () => [
        BlocPopularTvLoading(),
        const BlocPopularTvError('Failed'),
      ],
    );
  });
}
