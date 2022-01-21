import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  PopularBloc() : super(PopularInitial()) {
    on<PopularEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
