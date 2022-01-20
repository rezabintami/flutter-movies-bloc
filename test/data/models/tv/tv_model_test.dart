import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTVModel = TVModel(
    id: 1,
    name: 'name',
    originalName: 'originalName',
    voteCount: 3,
    overview: 'overview',
    posterPath: 'posterPath',
    backdropPath: 'backdropPath',
    voteAverage: 1.0,
    firstAirDate: 'firstAirDate',
    popularity: 1.0,
    genreIds: [1, 2, 3],
  );

  final tTV = TV(
    id: 1,
    name: 'name',
    originalName: 'originalName',
    voteCount: 3,
    overview: 'overview',
    posterPath: 'posterPath',
    backdropPath: 'backdropPath',
    voteAverage: 1.0,
    firstAirDate: 'firstAirDate',
    popularity: 1.0,
    genreIds: [1, 2, 3],
  );

  test('should be a subclass of TV entity', () async {
    final result = tTVModel.toEntity();
    expect(result, tTV);
  });
}
