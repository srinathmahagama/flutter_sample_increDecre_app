import 'package:bloc/bloc.dart';
import 'package:my_app/bloc/counter_event.dart';
import 'package:my_app/bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(counter: 0));

  void onIncrement() {
    add(IncrementEvent());
  }

  void onDecrement() {
    add(DecrementEvent());
  }

  @override
  Stream<CounterState> mapEventToState(CounterEvent event) async* {
    if (event is IncrementEvent) {
      yield* _increment();
    } else if (event is DecrementEvent) {
      yield* _decrement();
    }
  }

  Stream<CounterState> _increment() async* {
    int count = state.counter;
    count = count + 1;
    yield CounterState(counter: count);
  }

  Stream<CounterState> _decrement() async* {
    int count = state.counter;
    count = count - 1;
    yield CounterState(counter: count);
  }
}
