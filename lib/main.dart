import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './bloc/block.dart';
import './ticker.dart';
import 'UI/my_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Timer App',
        theme: ThemeData(
          primaryColor: Colors.pink[700],
          accentColor: Colors.pink[700],
          brightness: Brightness.dark,
        ),
        home: BlocProvider(
          create: (context) => TimerBloc(ticker: Ticker()),
          child: MyHomePage(),
        ));
  }
}
