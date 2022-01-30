import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/presentation/blocs/top_rated/top_rated_bloc.dart';

import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTV])
void main() {
  late MockGetTopRatedTV mockGetTopRatedTV;
  late TopRatedBloc topRatedBloc;

  setUp(() {
    mockGetTopRatedTV = MockGetTopRatedTV();
    topRatedBloc = TopRatedBloc(mockGetTopRatedTV);
  });

  final tTV = TV(
    id: 1,
    name: 'name',
    originalName: 'originalName',
    voteCount: 3,
    overview: 'overview',
    posterPath: 'posterPath',
    backdropPath: 'backdropPath',
    voteAverage: 1.0,
    firstAirDate: 'firstAirDate',
    popularity: 1.0,
    genreIds: [1, 2, 3],
  );
  final tTVList = <TV>[tTV];

  test('initial state should be empty', () {
    expect(topRatedBloc.state, TopRatedInitial());
  });

  blocTest<TopRatedBloc, TopRatedState>(
    'Should emit [Loading, HasData] when top-rated-tv data is gotten successfully',
    build: () {
      when(mockGetTopRatedTV.execute()).thenAnswer((_) async => Right(tTVList));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(TopRatedFetch()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedLoading(),
      TopRatedLoaded(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTV.execute());
    },
  );

  blocTest<TopRatedBloc, TopRatedState>(
    'Should emit [Loading, Error] when get top-rated-tv data is unsuccessful',
    build: () {
      when(mockGetTopRatedTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return topRatedBloc;
    },
    act: (bloc) => bloc.add(TopRatedFetch()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TopRatedLoading(),
      TopRatedError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTV.execute());
    },
  );
}
