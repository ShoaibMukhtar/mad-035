import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASSIGNMENT NO 2',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  int _prevIncrementValue = 1;

  void _incrementCounter(int value) {
    setState(() {
      _counter += value;
      _prevIncrementValue = value;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Counter incremented by $value'),
      ),
    );
  }

  void _decrementCounter() {
    setState(() {
      if (_prevIncrementValue == 1) {
        _counter--;
      } else if (_prevIncrementValue == 2) {
        _counter -= 1;
      } else if (_prevIncrementValue == 3) {
        _counter -= 1;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Counter decremented by 1'),//$_prevIncrementValue
      ),
    );
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Counter reset'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('COUNTER APP 2.0'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16),
            Image.asset(
              'images/flutter_logo.png',
              width: 200,
              height: 200,
            ),
            Text(
              'Counter value:',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              '$_counter',
              style: TextStyle(fontSize: 48),
            ),

            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _incrementCounter(1),
                  child: Text('Increment'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _decrementCounter(),
                  child: Text('Decrement'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _resetCounter(),
                  child: Text('Reset'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _incrementCounter(2),
                  child: Text('Increment by 2'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => _incrementCounter(3),
                  child: Text('Increment by 3'),
                ),
              ],
            ),
          ],
        ),
      ),
      key: Key('counterScaffold'),
    );
  }
}
