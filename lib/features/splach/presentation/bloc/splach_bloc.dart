import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splach_event.dart';
part 'splach_state.dart';

class SplachBloc extends Bloc<SplachEvent, SplachState> {
  SplachBloc() : super(SplachInitial()) {
    on<SplachEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
