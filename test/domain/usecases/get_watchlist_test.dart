import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/usecases/get_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlist usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = GetWatchlist(mockWatchlistRepository);
  });

  final tWatchlist = <Watchlist>[];

  test('should get list of watch from the repository', () async {
    // arrange
    when(mockWatchlistRepository.getWatchlist())
        .thenAnswer((_) async => Right(tWatchlist));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tWatchlist));
  });
}
