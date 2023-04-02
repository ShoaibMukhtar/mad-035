import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(DiceApp());

class DiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DiceAppHomePage(),
    );
  }
}

class DiceAppHomePage extends StatefulWidget {
  @override
  _DiceAppHomePageState createState() => _DiceAppHomePageState();
}

class _DiceAppHomePageState extends State<DiceAppHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dice App'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: '1 Dice',
            ),
            Tab(
              text: '2 Dices',
            ),
            Tab(
              text: 'Custom Dices',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleDice(),
          DoubleDice(),
          CustomDice(),
        ],
      ),
    );
  }
}

class SingleDice extends StatefulWidget {
  @override
  _SingleDiceState createState() => _SingleDiceState();
}

class _SingleDiceState extends State<SingleDice> {
  int _diceNumber = 1;

  void _rollDice() {
    setState(() {
      _diceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/dice$_diceNumber.png',
            height: 200,
            width: 200,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Roll Dice'),
            onPressed: _rollDice,
          ),
        ],
      ),
    );
  }
}

class DoubleDice extends StatefulWidget {
  @override
  _DoubleDiceState createState() => _DoubleDiceState();
}

class _DoubleDiceState extends State<DoubleDice> {
  int _diceNumber1 = 1;
  int _diceNumber2 = 1;

  void _rollDice() {
    setState(() {
      _diceNumber1 = Random().nextInt(6) + 1;
      _diceNumber2 = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/dice$_diceNumber1.png',
                height: 200,
                width: 200,
              ),
              Image.asset(
                'assets/dice$_diceNumber2.png',
                height: 200,
                width: 200,
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Roll Dice'),
            onPressed: _rollDice,
          ),
        ],
      ),
    );
  }
}
class CustomDice extends StatefulWidget {
  @override
  _CustomDiceState createState() => _CustomDiceState();
}

class _CustomDiceState extends State<CustomDice> {
  int _numDice = 1;
  List<int> _diceNumbers = [1];
  void _rollDice() {
    List<int> newDiceNumbers = [];
    for (int i = 0; i < _numDice; i++) {
      newDiceNumbers.add(Random().nextInt(6) + 1);
    }
    setState(() {
      _diceNumbers = newDiceNumbers;
    });
  }

  void _updateNumDice(int value) {
    setState(() {
      _numDice = value;
      _diceNumbers = List.generate(_numDice, (index) => 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            children: _diceNumbers
                .map(
                  (number) => Padding(
                padding: EdgeInsets.all(10),
                child: Image.asset(
                  'assets/dice$number.png',
                  height: 200,
                  width: 200,
                ),
              ),
            )
                .toList(),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton<int>(
                value: _numDice,
                items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                    .map(
                      (value) => DropdownMenuItem<int>(
                    value: value,
                    child: Text('$value'),
                  ),
                )
                    .toList(),
                onChanged: (int? value) {
                  if (value != null) {
                    _updateNumDice(value);
                  }
                },
              ),
              ElevatedButton(
                child: Text('Roll Dice'),
                onPressed: _rollDice,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
