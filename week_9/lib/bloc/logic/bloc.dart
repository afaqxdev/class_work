import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:week_9/bloc/logic/bloc_event.dart';
import 'package:week_9/bloc/logic/bloc_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(19)) {
    on<Increment>(
      (event, emit) {
        emit(CounterState(state.counter + 1));
      },
    );
  }
}
