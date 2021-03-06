import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetPopularTv usecase;
  late MockTvRepository mockTvRpository;

  setUp(() {
    mockTvRpository = MockTvRepository();
    usecase = GetPopularTv(mockTvRpository);
  });

  final tvs = <Tv>[];

  group('GetPopularTv Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRpository.getPopularTv())
            .thenAnswer((_) async => Right(tvs));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tvs));
      });
    });
  });
}
