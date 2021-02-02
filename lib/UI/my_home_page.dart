import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/timer_bloc.dart';
import '../bloc/timer_events.dart';
import '../bloc/timer_states.dart';
import 'actions.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Timer App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          WaveWidget(
            config: CustomConfig(
              gradients: [
                [
                  Colors.pink[700],
                  Colors.pink[300],
                  Colors.grey[400],
                ],
                [
                  Colors.pink[700],
                  Colors.pink[300],
                  Colors.grey[500],
                ],
                [
                  Colors.pink[700],
                  Colors.pink[300],
                  Colors.grey[400],
                ]
              ],
              durations: [19440, 10000, 6000],
              heightPercentages: [0.03, 0.01, 0.02],
              gradientBegin: Alignment.bottomCenter,
              gradientEnd: Alignment.topCenter,
            ),
            size: Size(double.infinity, double.infinity),
            backgroundColor: Colors.blue[50],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<TimerBloc, TimerState>(
                      buildWhen: (previousState, currentState) =>
                          currentState.runtimeType != previousState.runtimeType,
                      builder: (context, state) {
                        if (state is InitialState || state is Ready)
                          return FloatingActionButton(
                            child: Icon(Icons.minimize),
                            onPressed: () =>
                                BlocProvider.of<TimerBloc>(context).add(
                              Decrement(),
                            ),
                          );
                        return SizedBox();
                      },
                    ),
                    Center(
                      child: BlocBuilder<TimerBloc, TimerState>(
                        builder: (context, state) {
                          final String minutesSection =
                              ((state.duration / 60) % 60)
                                  .floor()
                                  .toString()
                                  .padLeft(2, '0');

                          final String secondsSection = (state.duration % 60)
                              .floor()
                              .toString()
                              .padLeft(2, '0');

                          return Text(
                            '$minutesSection:$secondsSection',
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                    BlocBuilder<TimerBloc, TimerState>(
                      buildWhen: (previousState, currentState) =>
                          currentState.runtimeType != previousState.runtimeType,
                      builder: (context, state) {
                        if (state is InitialState || state is Ready)
                          return FloatingActionButton(
                            child: Icon(Icons.add),
                            onPressed: () =>
                                BlocProvider.of<TimerBloc>(context).add(
                              Increment(),
                            ),
                          );
                        return SizedBox();
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<TimerBloc, TimerState>(
                buildWhen: (previousState, currentState) =>
                    currentState.runtimeType != previousState.runtimeType,
                builder: (context, state) => TimerActions(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
