import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_tv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTVWatchlist usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = RemoveTVWatchlist(mockWatchlistRepository);
  });

  test('should remove tv from watchlist', () async {
    // arrange
    when(mockWatchlistRepository.removeTVWatchlist(testTVDetail))
        .thenAnswer((_) async => Right(watchlistRemoveSuccessMessage));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    expect(result, Right(watchlistRemoveSuccessMessage));
  });
}
