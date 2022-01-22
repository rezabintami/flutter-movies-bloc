import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final GetTopRatedTV getTopRatedTV;
  TopRatedBloc(this.getTopRatedTV) : super(TopRatedInitial()) {
    on<TopRatedFetch>((event, emit) async {
      emit(TopRatedLoading());
      final result = await getTopRatedTV.execute();
      result.fold(
        (failure) {
          emit(TopRatedError(failure.message));
        },
        (tvData) {
          emit(TopRatedLoaded(tvData));
        },
      );
    });
  }
}
