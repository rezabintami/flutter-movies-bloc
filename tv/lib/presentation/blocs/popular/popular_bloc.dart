import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final GetPopularTV getPopularTV;
  PopularBloc(this.getPopularTV) : super(PopularInitial()) {
    on<PopularFetch>((event, emit) async {
      emit(PopularLoading());
      final result = await getPopularTV.execute();
      result.fold(
        (failure) {
          emit(PopularError(failure.message));
        },
        (tvData) {
          emit(PopularLoaded(tvData));
        },
      );
    });
  }
}
