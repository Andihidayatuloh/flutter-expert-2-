import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetTopTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTopTv(mockTvRepository);
  });

  final tMovies = <Tv>[];

  test('should get list of movies from repository', () async {
    // arrange
    when(mockTvRepository.getTopTv())
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tMovies));
  });
}
