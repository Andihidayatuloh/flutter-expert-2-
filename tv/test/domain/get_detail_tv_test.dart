import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../data_dummy/dummy_objects.dart';
import '../helpers/test_helper_tv.mocks.dart';

void main() {
  late GetTvDetail usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvDetail(mockTvRepository);
  });

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockTvRepository.getTvDetail(1))
        .thenAnswer((_) async => Right(testTvDetail));
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, Right(testTvDetail));
  });
}
