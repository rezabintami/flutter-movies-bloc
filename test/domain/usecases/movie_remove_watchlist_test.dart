import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_movie_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveMovieWatchlist usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = RemoveMovieWatchlist(mockWatchlistRepository);
  });

  test('should remove movie from watchlist', () async {
    // arrange
    when(mockWatchlistRepository.removeMovieWatchlist(testMovieDetail))
        .thenAnswer((_) async => Right(watchlistRemoveSuccessMessage));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    expect(result, Right(watchlistRemoveSuccessMessage));
  });
}
