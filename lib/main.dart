import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/bloc/bloc.dart';
import 'package:flutterapp/bloc/event.dart';

void main() => runApp(Counter());

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Counter App",
        home: BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(),
          child: CounterPage(),
        ));
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: BlocConsumer<CounterBloc, int>(
        listener: (context, state) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text('Counter: $state')));
        },
        builder: (context, count) {
          return Center(
            child: Text(
              'You have pushed the button this many times\n$count',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => counterBloc.add(CounterEvent.increment),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: () => counterBloc.add(CounterEvent.decrement),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.refresh),
              onPressed: () => counterBloc.add(CounterEvent.refresh),
            ),
          ),
        ],
      ),
    );
  }
}
