import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/entities.dart';
import 'package:tv/domain/usecases/search_tv.dart';
import 'package:tv/presentation/blocs/search/search_bloc.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTV])
void main() {
  late MockSearchTV mockSearchTV;
  late SearchBloc searchBloc;

  setUp(() {
    mockSearchTV = MockSearchTV();
    searchBloc = SearchBloc(mockSearchTV);
  });

  final String query = 'spiderman';
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
    expect(searchBloc.state, SearchEmpty());
  });

  blocTest<SearchBloc, SearchState>(
    'Should emit [Loading, HasData] when search-tv data is gotten successfully',
    build: () {
      when(mockSearchTV.execute(query)).thenAnswer((_) async => Right(tTVList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(query)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockSearchTV.execute(query));
    },
  );

  blocTest<SearchBloc, SearchState>(
    'Should emit [Loading, Error] when get search-tv data is unsuccessful',
    build: () {
      when(mockSearchTV.execute(query))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(query)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTV.execute(query));
    },
  );

  blocTest<SearchBloc, SearchState>(
    'Should emit [Loading, Empty] when get search-tv data is successful but empty',
    build: () {
      when(mockSearchTV.execute(query)).thenAnswer((_) async => Right([]));
      return searchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(query)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasData([]),
    ],
    verify: (bloc) {
      verify(mockSearchTV.execute(query));
    },
  );
}
