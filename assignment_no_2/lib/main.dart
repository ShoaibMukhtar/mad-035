
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COUNTER APP 2.0',
      theme: ThemeData(
        primaryColor: Colors.purple[900],
        accentColor: Colors.purpleAccent,
        backgroundColor: Colors.grey[300],
        scaffoldBackgroundColor: Colors.lightGreen,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.purple[900],
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            color: Colors.purple[900],
            fontSize: 18.0,
          ),
          button: TextStyle(
            color: Colors.red,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
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
  List<int> _counters = [0, 0, 0];
  int _currentIndex = 0;

  void _decrementCounters() {
    setState(() {
      for (int i = 0; i < _counters.length; i++) {
        if (_counters[i] > 0) _counters[i]--;
      }
    });
  }

  void _incrementCounters() {
    setState(() {
      switch (_currentIndex) {
        case 0:
          _counters[_currentIndex]++;
          break;
        case 1:
          _counters[_currentIndex] += 2;
          break;
        case 2:
          _counters[_currentIndex] += 3;
          break;
      }
    });
  }

  void _resetCounters() {
    setState(() {
      for (int i = 0; i < _counters.length; i++) {
        _counters[i] = 0;
      }
    });
  }

  void _changeCounter(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> counterTabs = [      Tab(        text: 'Counter 1',      ),      Tab(        text: 'Counter 2',      ),      Tab(        text: 'Counter 3',      ),    ];

    List<Widget> counterTabViews = [      Text(        'Counter 1: ${_counters[0]}',        style: TextStyle(fontSize: 24),      ),      Text(        'Counter 2: ${_counters[1]}',        style: TextStyle(fontSize: 24),      ),      Text(        'Counter 3: ${_counters[2]}',        style: TextStyle(fontSize: 24),      ),    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(' Counter App 2.0'),
          bottom: TabBar(
            tabs: counterTabs,
            onTap: _changeCounter,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: counterTabViews,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _decrementCounters,
                    child: Text('Decrement'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _incrementCounters,
                    child: Text('Increment'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _resetCounters,
                    child: Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
