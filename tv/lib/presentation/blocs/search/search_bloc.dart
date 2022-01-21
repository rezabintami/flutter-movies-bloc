import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchTV _searchTV;

  SearchBloc(this._searchTV) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchTV.execute(query);

      result.fold(
        (failure) {},
        (data) {
          emit(SearchHasData(data));
        },
      );
    });
  }
}
