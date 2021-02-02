import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable {
  final int duration;
  const TimerState(this.duration);
}

class InitialState extends TimerState {
  int init;
  InitialState({this.init}) : super(init);

  @override
  List<Object> get props => [init];
}

class Ready extends TimerState {
  int duration;
  Ready(this.duration) : super(duration);

  @override
  List<Object> get props => [duration];
}

class Paused extends TimerState {
  int duration;
  Paused(this.duration) : super(duration);
  @override
  List<Object> get props => [duration];
}

class Running extends TimerState {
  int duration;
  Running(this.duration) : super(duration);
  @override
  List<Object> get props => [duration];
}

class Finished extends TimerState {
  int duration;
  Finished(this.duration) : super(0);
  @override
  List<Object> get props => [duration];
}
