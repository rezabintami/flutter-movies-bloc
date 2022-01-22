import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'now_playing_event.dart';
part 'now_playing_state.dart';

class NowPlayingBloc extends Bloc<NowPlayingEvent, NowPlayingState> {
  final GetNowPlayingTV getNowPlayingTV;
  NowPlayingBloc(this.getNowPlayingTV) : super(NowPlayingInitial()) {
    on<GetNowPlayingFetch>((event, emit) async {
      emit(NowPlayingLoading());
      final result = await getNowPlayingTV.execute();
      result.fold(
        (failure) {
          emit(NowPlayingError(failure.message));
        },
        (tvData) {
          emit(NowPlayingLoaded(tvData));
        },
      );
    });
  }
}
