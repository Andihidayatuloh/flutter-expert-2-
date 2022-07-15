import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:search/search.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'search_tv_bloc_test.mocks.dart';

import '../../../../../tv/test/data_dummy/dummy_objects.dart';

@GenerateMocks([SearchTv])
void main() {
  late BlocTvSearchBloc blocs;
  late SearchTvMocks mocks;

  setUpAll(() {
    mocks = SearchTvMocks();
    blocs = BlocTvSearchBloc(search: mocks);
  });

  group('Test Search Tv', () {
    test('state harus sudah kosong', () {
      expect(blocs.state, BlocTvSearchEmpty());
    });

    blocTest<BlocTvSearchBloc, BlocTvSearchState>(
      'harus menampilkan [Loading, Data] saat data pencarian sudah didapatkan',
      build: () {
        when(mocks.execute(query)).thenAnswer((_) async => Right(tTvModel));
        return blocs;
      },
      act: (bloc) => bloc.add(OnQueryTvChanged(query)),
      wait: const Duration(milliseconds: 500),
      expect: () {
        [BlocTvSearchLoading(), BlocTvSearchLoaded(tTvModel)];
      },
      verify: (bloc) => verify(mocks.execute(query)),
    );

    blocTest<BlocTvSearchBloc, BlocTvSearchState>(
      'harus menampilkan [Loading, Error] saat data pencarian gagal didapatkan',
      build: () {
        when(mocks.execute(query))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return blocs;
      },
      act: (bloc) => bloc.add(OnQueryTvChanged(query)),
      wait: const Duration(milliseconds: 500),
      expect: () {
        [BlocTvSearchLoading(), BlocTvSearchError('Server Failure')];
      },
      verify: (bloc) => verify(mocks.execute(query)),
    );
  });
}
