import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../data_dummy/dummy_objects.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late GetMovieDetail usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieDetail(mockMovieRepository);
  });

  test('should get movie detail from the repository', () async {
    // arrange
    when(mockMovieRepository.getMovieDetail(1))
        .thenAnswer((_) async => Right(testMovieDetail));
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, Right(testMovieDetail));
  });
}
