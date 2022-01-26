import 'package:ditonton/domain/usecases/get_movie_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetMovieWatchListStatus usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = GetMovieWatchListStatus(mockWatchlistRepository);
  });

  final tMovie = 1;
  test('should get status movie from watchlist', () async {
    // arrange
    when(mockWatchlistRepository.isAddedMovieToWatchlist(tMovie))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(tMovie);
    // assert
    expect(result, true);
  });
}
