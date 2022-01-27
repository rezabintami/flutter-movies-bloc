import 'package:ditonton/domain/usecases/get_tv_watchlist_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVWatchListStatus usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = GetTVWatchListStatus(mockWatchlistRepository);
  });

  final tTV = 1;
  test('should get status tv from watchlist', () async {
    // arrange
    when(mockWatchlistRepository.isAddedTVToWatchlist(tTV))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(tTV);
    // assert
    expect(result, true);
  });
}
