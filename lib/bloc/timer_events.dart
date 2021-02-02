import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class TimerEvent extends Equatable {
  const TimerEvent();
  @override
  List<Object> get props => [];
}

class Start extends TimerEvent {
  final int duration;
  const Start({@required this.duration});

  @override
  String toString() {
    return 'Start {Duration : $duration}';
  }
}

class Pause extends TimerEvent {}

class Resume extends TimerEvent {}

class Reset extends TimerEvent {}

class Increment extends TimerEvent {}

class Decrement extends TimerEvent {}

class Tick extends TimerEvent {
  final int duration;
  const Tick({@required this.duration});
  @override
  List<Object> get props => [duration];
  @override
  String toString() {
    return 'Start {Duration : $duration}';
  }
}
