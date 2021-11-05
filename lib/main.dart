import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/counter_bloc.dart';
import 'package:my_app/bloc/counter_event.dart';

import 'bloc/counter_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _counterBloc = CounterBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => _counterBloc,
        child: Counter(widget: widget));
  }

  @override
  void dispose() {
    _counterBloc.close();
    super.dispose();
  }
}

class Counter extends StatelessWidget {
  const Counter({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final MyHomePage widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocBuilder(
            bloc: BlocProvider.of<CounterBloc>(context),
            builder: (context, CounterState state) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'You have pushed the button this many times:',
                    ),
                    Text(
                      '${state.counter}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              );
            }),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () =>
                  BlocProvider.of<CounterBloc>(context).add(IncrementEvent()),
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () =>
                  BlocProvider.of<CounterBloc>(context).add(DecrementEvent()),
              tooltip: 'Increment',
              child: Icon(Icons.remove),
            )
          ], // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
