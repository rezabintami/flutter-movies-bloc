import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/presentation/blocs/popular/popular_bloc.dart';

import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTV])
void main() {
  late MockGetPopularTV mockGetPopularTV;
  late PopularBloc popularMoviesBloc;

  setUp(() {
    mockGetPopularTV = MockGetPopularTV();
    popularMoviesBloc = PopularBloc(mockGetPopularTV);
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
    expect(popularMoviesBloc.state, PopularInitial());
  });

  blocTest<PopularBloc, PopularState>(
    'Should emit [Loading, HasData] when popular-tv data is gotten successfully',
    build: () {
      when(mockGetPopularTV.execute()).thenAnswer((_) async => Right(tTVList));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(PopularFetch()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularLoading(),
      PopularLoaded(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTV.execute());
    },
  );

  blocTest<PopularBloc, PopularState>(
    'Should emit [Loading, Error] when get popular-tv data is unsuccessful',
    build: () {
      when(mockGetPopularTV.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(PopularFetch()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      PopularLoading(),
      PopularError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTV.execute());
    },
  );
}
