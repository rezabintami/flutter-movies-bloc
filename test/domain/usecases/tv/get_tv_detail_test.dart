import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';

import '../../../helpers/test_helper.mocks.dart';
import '../../../dummy_data/dummy_objects.dart';

void main() {
  late GetTVDetail usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVDetail(mockTVRepository);
  });

  final tId = 1;

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockTVRepository.getTVDetail(tId))
        .thenAnswer((_) async => Right(testTVDetail));
    // act
    final result = await usecase.execute(tId);
    // assert
    expect(result, Right(testTVDetail));
  });
}
