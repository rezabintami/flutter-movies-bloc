import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_tv_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveTVWatchlist usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = SaveTVWatchlist(mockWatchlistRepository);
  });

  test('should save tv to watchlist', () async {
    // arrange
    when(mockWatchlistRepository.saveTVWatchlist(testTVDetail))
        .thenAnswer((_) async => Right(watchlistAddSuccessMessage));
    // act
    final result = await usecase.execute(testTVDetail);
    // assert
    expect(result, Right(watchlistAddSuccessMessage));
  });
}
