import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTV usecase;
  late MockTVRepository mockTVRpository;

  setUp(() {
    mockTVRpository = MockTVRepository();
    usecase = SearchTV(mockTVRpository);
  });
  final query = "query";
  final tTV = <TV>[];

  group('GetSearchTV Tests', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute function is called',
          () async {
        // arrange
        when(mockTVRpository.searchTV(query))
            .thenAnswer((_) async => Right(tTV));
        // act
        final result = await usecase.execute(query);
        // assert
        expect(result, Right(tTV));
      });
    });
  });
}
