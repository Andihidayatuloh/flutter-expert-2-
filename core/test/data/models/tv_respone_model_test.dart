import 'dart:convert';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tResult = Result(
      backdropPath: "/path.jpg",
      genreIds: [1, 2, 3, 4],
      id: 1,
      name: 'name',
      originCountry: ['US'],
      originalLanguage: 'en',
      originalName: 'original Name',
      overview: 'overview',
      popularity: 1.0,
      posterPath: '/path.jpg',
      voteAverage: 1.0,
      voteCount: 1);

  final tTvResponseModel = TvResponse(tvlist: <Result>[tResult]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/on_the_air.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();

      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "name": "name",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "original Name",
            "overview": "overview",
            "popularity": 1.0,
            "poster_path": "/path.jpg",
            "vote_average": 1.0,
            "vote_count": 1,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
