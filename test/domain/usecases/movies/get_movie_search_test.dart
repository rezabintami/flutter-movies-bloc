import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/usecases.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SearchMovies usecase;
  late MockMovieRepository mockMovieRpository;

  setUp(() {
    mockMovieRpository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRpository);
  });
  final query = "query";
  final tMovies = <Movie>[];

  group('GetSearchMovies Tests', () {
    group('execute', () {
      test(
          'should get list of movies from the repository when execute function is called',
          () async {
        // arrange
        when(mockMovieRpository.searchMovies(query))
            .thenAnswer((_) async => Right(tMovies));
        // act
        final result = await usecase.execute(query);
        // assert
        expect(result, Right(tMovies));
      });
    });
  });
}
