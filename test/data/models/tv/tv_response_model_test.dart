import 'dart:convert';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tTVModel = TVModel(
    id: 85552,
    name: 'Euphoria',
    originalName: 'Euphoria',
    voteCount: 5345,
    overview:
        'A group of high school students navigate love and friendships in a world of drugs, sex, trauma, and social media.',
    posterPath: '/jtnfNzqZwN4E32FGGxx1YZaBWWf.jpg',
    backdropPath: '/oKt4J3TFjWirVwBqoHyIvv5IImd.jpg',
    voteAverage: 8.4,
    firstAirDate: '2019-06-16',
    popularity: 4693.693,
    genreIds: [],
  );
  final tTVResponseModel = TVResponse(tvList: <TVModel>[tTVModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv/tv_now_playing.json'));
      // act
      final result = TVResponse.fromJson(jsonMap);
      // assert
      expect(result, tTVResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTVResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/oKt4J3TFjWirVwBqoHyIvv5IImd.jpg",
            "first_air_date": "2019-06-16",
            "genre_ids": [],
            "id": 85552,
            "name": "Euphoria",
            "original_name": "Euphoria",
            "overview":
                "A group of high school students navigate love and friendships in a world of drugs, sex, trauma, and social media.",
            "popularity": 4693.693,
            "poster_path": "/jtnfNzqZwN4E32FGGxx1YZaBWWf.jpg",
            "vote_average": 8.4,
            "vote_count": 5345
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
