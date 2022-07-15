import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetTopTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTopTv(mockTvRepository);
  });

  final tvs = <Tv>[];

  test('should get list of movies from repository', () async {
    // arrange
    when(mockTvRepository.getTopTv()).thenAnswer((_) async => Right(tvs));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tvs));
  });
}
