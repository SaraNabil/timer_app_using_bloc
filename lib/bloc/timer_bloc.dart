import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/timer_events.dart';
import '../bloc/timer_states.dart';
import '../ticker.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static int _initialDuration = 60;

  int _duration = _initialDuration;
  final Ticker _ticker;
  StreamSubscription _tickerSubscription;

  TimerBloc({@required Ticker ticker})
      : _ticker = ticker,
        super(InitialState(init: _initialDuration));

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is Increment) {
      _tickerSubscription?.cancel();
      yield Ready(++_duration);
    } else if (event is Decrement) {
      _tickerSubscription?.cancel();
      yield Ready(--_duration);
    }
    if (event is Start) {
      yield Running(_duration);
      _tickerSubscription?.cancel();
      _tickerSubscription = _ticker.tick(ticks: _duration).listen((_duration) {
        add(Tick(duration: _duration));
      });
    } else if (event is Pause) {
      if (state is Running) {
        _tickerSubscription?.pause();
        yield Paused(state.duration);
      }
    } else if (event is Resume) {
      _tickerSubscription?.resume();
      yield Running(state.duration);
    } else if (event is Reset) {
      _tickerSubscription?.cancel();
      _duration = _initialDuration;
      yield InitialState(init: _initialDuration);
    } else if (event is Tick) {
      Tick tick = event;
      yield tick.duration > 0 ? Running(tick.duration) : Finished(0);
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
