import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetTvRecommendations usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvRecommendations(mockTvRepository);
  });

  final tvs = <Tv>[];

  test('should get list of movie recommendations from the repository',
      () async {
    // arrange
    when(mockTvRepository.getTvRecommendation(1))
        .thenAnswer((_) async => Right(tvs));
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, Right(tvs));
  });
}
