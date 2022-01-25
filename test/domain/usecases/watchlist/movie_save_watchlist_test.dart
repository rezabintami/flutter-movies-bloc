import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_movie_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveMovieWatchlist usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = SaveMovieWatchlist(mockWatchlistRepository);
  });

  test('should save movie to watchlist', () async {
    // arrange
    when(mockWatchlistRepository.saveMovieWatchlist(testMovieDetail))
        .thenAnswer((_) async => Right(watchlistAddSuccessMessage));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    expect(result, Right(watchlistAddSuccessMessage));
  });
}
